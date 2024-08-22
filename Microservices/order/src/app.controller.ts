import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { MessagePattern } from '@nestjs/microservices';
import { createOrderEvent } from './Events/create-order.event';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) { }

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @MessagePattern({ cmd: 'create-order' })
  handleOrder(data: createOrderEvent) {
    return this.appService.handleOrder(data);
  }

}
