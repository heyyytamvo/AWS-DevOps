import { Body, Controller, Get, Post } from '@nestjs/common';
import { AppService } from './app.service';
import { createOrderDto } from './Dto/create-order.event';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) { }

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('create-order')
  async handleOrder(@Body() data: createOrderDto) {
    return await this.appService.handleOrder(data);
  }

}
