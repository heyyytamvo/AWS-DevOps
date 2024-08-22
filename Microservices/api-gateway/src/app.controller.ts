import { Body, Controller, Get, Post } from '@nestjs/common';
import { AppService } from './app.service';
import { createOrderDto } from './create-order.dto';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('create-order')
  createOrder(@Body() createOrder: createOrderDto){
    return this.appService.createOrder(createOrder);
  }

  @Get('get-orders')
  getAllOrder(){
    return this.appService.getAllOrder();
  }
}
