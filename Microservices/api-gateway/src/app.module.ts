import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ClientsModule, Transport } from '@nestjs/microservices';

@Module({
  imports: [
    ClientsModule.register([
      {
        name: 'ORDER',
        transport: Transport.TCP,
        options: { 
          host: '0.0.0.0',
          port: 3001 
        }
      },
      {
        name: 'INFO',
        transport: Transport.TCP,
        options: { 
          host: '0.0.0.0',
          port: 3002 
        }
      },
    ])
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
