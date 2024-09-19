import { HttpInterceptorFn } from '@angular/common/http';

export const customInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem('token');
  if (req.url.includes('/auth/login') || req.url.includes('/auth/signup')) {
    return next(req);
  }
  if(token){
    const clonedReq = req.clone({
      headers: req.headers.set('Authorization', 'Bearer ' + token)
    });
    return next(clonedReq);
  }
  return next(req);
};
