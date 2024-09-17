import { ChangeDetectionStrategy, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { on } from 'events';
import { AuthService } from '../../core/services/AuthService';
import { response } from 'express';
import { CommonModule } from '@angular/common';


@Component({
  selector: 'app-home-admin',
  standalone: true,
  imports: [CommonModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './home-admin.component.html',
  styleUrl: './home-admin.component.scss'
})
export class HomeAdminComponent implements OnInit {
  testResponse: string = '';

  constructor(private authService: AuthService, private cdRef: ChangeDetectorRef) { }

  ngOnInit(): void {
    this.test();
  }

  test() {
    this.authService.adminTest().subscribe(
      (response) => {
        this.testResponse = response.message;  // Almacena la respuesta
        console.log("Response from server: ", this.testResponse);
        this.cdRef.detectChanges();  // Fuerza la actualización de la vista
      },
      (error) => {
        console.error('Error fetching admin test response', error);
      }
    );
  }
}
