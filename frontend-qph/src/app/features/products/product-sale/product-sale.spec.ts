import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProductSale } from './product-sale';

describe('ProductSale', () => {
  let component: ProductSale;
  let fixture: ComponentFixture<ProductSale>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ProductSale],
    }).compileComponents();

    fixture = TestBed.createComponent(ProductSale);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
