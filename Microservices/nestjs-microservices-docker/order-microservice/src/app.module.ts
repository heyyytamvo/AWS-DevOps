import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { OrderModule } from './order/order.module';
import { db_host, db_name, db_user, db_password } from './config';

@Module({
  imports: [
    MongooseModule.forRoot(`mongodb+srv://${db_user}:${db_password}@microservice.mv4kp.mongodb.net/?retryWrites=true&w=majority&appName=MicroService`),
    OrderModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule { }
