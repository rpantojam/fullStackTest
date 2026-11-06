
import { Component, inject, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ProductService } from '../../../core/services/product';
import { merge, Subscription } from 'rxjs';

// PrimeNG
import { CardModule } from 'primeng/card';
import { InputTextModule } from 'primeng/inputtext';
import { InputNumberModule } from 'primeng/inputnumber';
import { ButtonModule } from 'primeng/button';
import { ToastModule } from 'primeng/toast';
import { MessageService } from 'primeng/api';

@Component({
  selector: 'app-product-sale',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    CardModule,
    InputTextModule,
    InputNumberModule,
    ButtonModule,
    ToastModule
  ],
  providers: [MessageService],
  templateUrl: './product-sale.html',
  styleUrls: ['./product-sale.scss']
})
export class ProductSaleComponent implements OnInit, OnDestroy {

  private fb = inject(FormBuilder);
  private productService = inject(ProductService);
  private router = inject(Router);
  private route = inject(ActivatedRoute);
  private messageService = inject(MessageService);

  private calculationSubscription?: Subscription;

  form = this.fb.group({
    nombre: ['', [Validators.required, Validators.minLength(2)]],
    precio: [null as number | null, [Validators.required, Validators.min(0.01)]],
    stock: [null as number | null, [Validators.required, Validators.min(0)]],
    total: [null as number | null, [Validators.required, Validators.min(0.01)]],
    amount: [null as number | null, [Validators.required, Validators.min(1)]]
  });

  productId?: number;
  loading = false;
  submitting = false;

  ngOnInit(): void {

    // Detectar cambios en precio y cantidad
    this.calculationSubscription = merge(
      this.form.controls.amount.valueChanges,
      this.form.controls.precio.valueChanges
    ).subscribe(() => {
      this.calculateTotal();
      this.validateStock();
    });

    const id = this.route.snapshot.paramMap.get('id');

    this.productId = Number(id);

    this.loadProduct(this.productId);
  }

  // Calcular el precio total de venta
  private calculateTotal(): void {

    const precio = this.form.controls.precio.value;
    const amount = this.form.controls.amount.value;

    if (precio !== null && amount !== null && precio > 0 && amount > 0) {

      const total = precio * amount;

      this.form.controls.total.setValue(total, {
        emitEvent: false
      });

    } else {

      this.form.controls.total.setValue(null, {
        emitEvent: false
      });

    }
  }

  private loadProduct(id: number): void {

    this.loading = true;

    this.productService.getById(id).subscribe({
      next: (product) => {
        this.form.patchValue(product);
        this.validateStock();
        this.loading = false;
      },
      error: () => {
        this.messageService.add({
          severity: 'error',
          summary: 'Error',
          detail: 'No se pudo cargar el producto'
        });

        this.loading = false;
      }
    });
  }

  onSubmit(): void {

    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    const { precio, amount } = this.form.getRawValue();

    if (this.productId == null || precio == null || amount == null) {
      return;
    }

    this.submitting = true;

    // Construir el objeto que recibirá el API
    const data = {
      productId: this.productId,
      unitaryPrice: precio,
      amount: amount
    };

    const request = this.productService.sale(data);

    request.subscribe({
      next: () => {

        this.messageService.add({
          severity: 'success',
          summary: 'Éxito',
          detail: 'Venta registrada'
        });

        setTimeout(() => this.router.navigate(['/products']), 1500);
      },
      error: (err) => {

        this.messageService.add({
          severity: 'error',
          summary: 'Error',
          detail: err.error?.error ?? 'Error al guardar el producto'
        });

        this.submitting = false;
      }
    });
  }

  ngOnDestroy(): void {
    this.calculationSubscription?.unsubscribe();
  }

  goBack(): void {
    this.router.navigate(['/products']);
  }

  private validateStock(): void {
    const amountControl = this.form.controls.amount;

    const amount = amountControl.value;
    const stock = this.form.controls.stock.value;

    if (amount !== null && stock !== null && amount > stock) {
      amountControl.setErrors({
        ...amountControl.errors,
        exceedsStock: true
      });
    } else if (amountControl.hasError('exceedsStock')) {
      const errors = { ...amountControl.errors };
      delete errors['exceedsStock'];

      amountControl.setErrors(
        Object.keys(errors).length ? errors : null
      );
    }
  }
}
