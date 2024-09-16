import { Component, OnInit } from '@angular/core';
import { on } from 'events';
import { AuthService } from '../../core/services/AuthService';
import { response } from 'express';
import { CommonModule } from '@angular/common';


@Component({
  selector: 'app-home-admin',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home-admin.component.html',
  styleUrl: './home-admin.component.scss'
})
export class HomeAdminComponent implements OnInit {
  testResponse: any ={};
  constructor(private authService: AuthService) { }
  ngOnInit(): void {
    this.test();
  }




  test() {
    this.authService.adminTest().subscribe(
      (response: any) => {
        if (response) {
          console.log('Response => ', response);
          this.testResponse = response;
          console.log("testResponse => ", this.testResponse);
        } else {
          console.log('No response');
        }
      },
      (error) => {
        console.error('Error fetching admin test response', error);
      }
    );
  }
  

}
