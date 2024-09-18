import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from '../models/User';
import { jwtDecode } from 'jwt-decode';
import { Observable } from 'rxjs';


@Injectable({
    providedIn: 'root'
})

export class AuthService {

    private readonly API_URL = 'http://192.168.41.203:8080';

    constructor(private http: HttpClient) { }

    login(user: User): Observable<{ token: string; refreshToken: string }> {
        const loginData = {
          email: user.email,
          password: user.password
        };
        return this.http.post<{ token: string; refreshToken: string }>(`${this.API_URL}/auth/login`, loginData);
      }
    signup(user: User) {
        const signupData = {
            email: user.email,
            password: user.password,
            cedula: user.cedula,
            name: user.name,
            area: user.area,
            headquarter: user.headquarter
        };
        return this.http.post(this.API_URL + "/auth/signup", signupData);

    }

    adminTest() {
        return this.http.get<{ message: string }>(this.API_URL + "/home/admin");
    }


    getTokens() {
        return localStorage.getItem('token');
    }


    decodeToken(token: string) {
        try {
            const decoededToken = jwtDecode(token);
            return jwtDecode(token);

        } catch (e) {
            console.error('Invalid token', e);
            return null;
        }
    }

    redirecBasedOnRole() {
        const token = this.getTokens();
        if (!token) {
            console.log('No token found');
            return 'auth/login';
        }else{
            const decoededToken: any = this.decodeToken(token);
            if (decoededToken.roles === 'ADMIN') {
                return 'home/admin';
            } else if (decoededToken.roles === 'USER') {
                return 'home/user';

            }else{
                console.log("Invalid role: " + decoededToken.roles);       
                return 'auth/login';
            }
        }

    }


}