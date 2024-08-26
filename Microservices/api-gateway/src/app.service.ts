import { Inject, Injectable } from '@nestjs/common';
import { createOrderDto } from './create-order.dto';
import { ClientProxy } from '@nestjs/microservices';
import { createOrderEvent } from './create-order.event';
import { lastValueFrom, map } from 'rxjs';
import { HttpService } from '@nestjs/axios';
import { AxiosRequestConfig, AxiosResponse } from 'axios';

@Injectable()
export class AppService {
  constructor(
    private readonly httpService: HttpService,
  ) {}
  getHello(): string {
    return 'Hello World!';
  }

  async createOrder(orderData: createOrderDto): Promise<any> {
    try {
      const requestConfig: AxiosRequestConfig = {
        method: 'post',
        url: 'http://localhost:3002/orders',
        data: orderData,
        headers: {
          'Content-Type': 'application/json'
        }
      };

      try {
        console.log('Sending POST request with body:', orderData);
        const response: AxiosResponse = await this.httpService.request(requestConfig).toPromise();
        console.log('Server response:', response.data);
        return response.data;
      } catch (error) {
        console.error('Error creating order:', error);
        if (error.response) {
          console.error('Server response:', error.response.data);
          console.error('Status code:', error.response.status);
          console.error('Status text:', error.response.statusText);
        } else {
          console.error('Error details:', error);
        }
        throw error;
      }

    } catch (error) {
      console.error('Error creating order:', error);

      if (error.response) {
        console.error('Server response:', error.response.data);
        console.error('Status code:', error.response.status);
        console.error('Status text:', error.response.statusText);
      } else {
        console.error('Error details:', error);
      }

      throw error;
    }
  }

    // return this.orderClient.send({ cmd: 'create-order' }, new createOrderEvent(_createOrderDto.name, _createOrderDto.age))


  async getAllOrder(): Promise<any> {
    try {
      const response = await this.httpService.get('http://localhost:3002/get-orders').toPromise();
      return response.data;
    } catch (error) {
      console.error('Error fetching orders:', error);
      throw error;
    }
  }
}
