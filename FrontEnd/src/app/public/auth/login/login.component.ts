import { ChangeDetectionStrategy, Component, NgModule } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { User } from '../../../core/models/User';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../../core/services/AuthService';
import { HttpClientModule } from '@angular/common/http';


@Component({
  selector: 'app-login',
  standalone: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterLink, FormsModule, ReactiveFormsModule, HttpClientModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.scss'
})
export class LoginComponent {

  loginForm: FormGroup;

  constructor(private fb: FormBuilder, private authService: AuthService, private router: Router) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]]
    });
  }

  onSubmit(){
    if(this.loginForm.valid){
      const user: User = this.loginForm.value;
      this.authService.login(user).subscribe(
        (response: any) => {
          if(response){
            alert('Login successful');
            console.log('Token:', response.token);
            console.log('Refresh Token:', response.refreshToken);
            localStorage.setItem('token', response.token);
            this.router.navigate(['/home/admin']);

          }
        },
        (error) => {
          alert('Login failed'+ error);
          console.error(error);
        }
      );

    }
  }


}
