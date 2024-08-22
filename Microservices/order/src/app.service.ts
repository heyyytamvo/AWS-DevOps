import { Injectable, NotAcceptableException } from '@nestjs/common';
import { createOrderEvent } from './Events/create-order.event';
import { InjectRepository } from '@nestjs/typeorm';
import { Order } from './Entities/order.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AppService {

  constructor(
    @InjectRepository(Order)
        private ordersRepository: Repository<Order>
  ){};

  getHello(): string {
    return 'Hello World!';
  }

  async handleOrder(data: createOrderEvent) {

    // Find order by name
    const name = data.name;
    const orderByName = await this.ordersRepository.findOneBy({ name });

    if (orderByName) {
      return new NotAcceptableException("Name already exist");
    }

    const newOrder = this.ordersRepository.create(data);
    return await this.ordersRepository.save(newOrder);
  }
}
