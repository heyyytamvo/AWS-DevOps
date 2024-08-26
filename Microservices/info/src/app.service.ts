import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Order } from './Entities/order.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AppService {

  constructor(
    @InjectRepository(Order) private ordersRepository: Repository<Order>
  ){};
  
  async getAllOrders(){
    return await this.ordersRepository.find();
  }

}
