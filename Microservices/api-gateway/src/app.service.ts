import { Inject, Injectable } from '@nestjs/common';
import { createOrderDto } from './create-order.dto';
import { ClientProxy } from '@nestjs/microservices';
import { createOrderEvent } from './create-order.event';

@Injectable()
export class AppService {
  constructor(
    @Inject('ORDER') private readonly orderClient: ClientProxy,
    @Inject('INFO') private readonly infoClient: ClientProxy
  ) {}
  getHello(): string {
    return 'Hello World!';
  }

  createOrder(_createOrderDto: createOrderDto){
    return this.orderClient.send({ cmd: 'create-order' }, new createOrderEvent(_createOrderDto.name, _createOrderDto.age))
  }

  getAllOrder(){
    return this.infoClient.send({ cmd: 'get-orders' }, {})
  }
}
