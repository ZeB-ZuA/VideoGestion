import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from '../models/User';


@Injectable({
    providedIn: 'root'
})

export class AuthService {

private readonly LOGIN_URL = 'http://localhost:8080/auth/login';
private readonly SIGNUP_URL = 'http://localhost:8080/auth/signup';

constructor(private http: HttpClient) { }

login(user: User){
    const loginData = {
        email: user.email,
        password: user.password
    };
    return this.http.post(this.LOGIN_URL, loginData);
}

signup(user: User){
    const signupData = {
        email: user.email,
        password: user.password,
        cedula: user.cedula,
        name: user.name,
        area: user.area,
        headquarter: user.headquarter
    };
    return this.http.post(this.SIGNUP_URL, signupData);

}


}