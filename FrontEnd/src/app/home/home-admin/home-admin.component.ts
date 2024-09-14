import { Component, OnInit } from '@angular/core';
import { on } from 'events';
import { AuthService } from '../../core/services/AuthService';
import { response } from 'express';


@Component({
  selector: 'app-home-admin',
  standalone: true,
  imports: [],
  templateUrl: './home-admin.component.html',
  styleUrl: './home-admin.component.scss'
})
export class HomeAdminComponent implements OnInit {
  testResponse: any;
  constructor(private authService: AuthService) { }
  ngOnInit(): void {
    this.test();
  }



  test() {
    this.authService.adminTest().subscribe(
      (response) => {
        if (response) {
          this.testResponse = response;
          console.log(response);
        } else {
          console.log('No response');
        }
      }
    )
  }


}
