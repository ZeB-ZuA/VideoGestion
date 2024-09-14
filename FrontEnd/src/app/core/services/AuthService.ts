import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from '../models/User';


@Injectable({
    providedIn: 'root'
})

export class AuthService {

private readonly API_URL = 'http://localhost:8080';

constructor(private http: HttpClient) { }

login(user: User){
    const loginData = {
        email: user.email,
        password: user.password
    };
    return this.http.post(this.API_URL+"/auth/login", loginData);
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
    return this.http.post(this.API_URL+"/auth/signup", signupData);

}

adminTest() {
   
    return this.http.get(this.API_URL + "/home/admin");
}


}