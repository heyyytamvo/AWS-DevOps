import { Injectable } from '@nestjs/common';
import { createOrderDto } from './create-order.dto';
import { HttpService } from '@nestjs/axios';
import { AxiosRequestConfig, AxiosResponse } from 'axios';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AppService {
  constructor(
    private readonly httpService: HttpService,
    private readonly configService: ConfigService
  ) {}
  getHello(): string {
    return 'Hello World!';
  }

  async createOrder(orderData: createOrderDto): Promise<any> {
    try {
      const requestConfig: AxiosRequestConfig = {
        method: 'post',
        url: `http://order-service:3001/create-order`,
        data: orderData,
        headers: {
          'Content-Type': 'application/json'
        }
      };
        
      const response: AxiosResponse = await this.httpService.request(requestConfig).toPromise();
        return response.data;
      } catch (error) {
        console.error('Error creating order:', error);
        throw error;
      }
  }
  
  async getAllOrder(): Promise<any> {
    try {
      const response = await this.httpService.get(`http://info-service:3002/get-orders`).toPromise();
      return response.data;
    } catch (error) {
      console.error('Error fetching orders:', error);
      throw error;
    }
  }
}
