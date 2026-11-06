import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Users } from '../../shared/models/user.model';

@Injectable({ providedIn: 'root' })
export class RegisterService {

  private readonly apiUrl = 'http://localhost:8080/api/auth/v0/user';

  constructor(private http: HttpClient) {}

  create(user: Users): Observable<Users> {
    return this.http.post<Users>(this.apiUrl, user);
  }
}