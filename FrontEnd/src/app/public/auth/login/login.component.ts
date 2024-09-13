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
        (response) => {
          if(response){
           console.log('credentials= ', response);
          }
        },
        (error) => {
          console.error(error);
        }
      );

    }
  }


}
