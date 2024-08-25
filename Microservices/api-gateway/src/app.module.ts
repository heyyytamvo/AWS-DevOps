import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { ConfigModule, ConfigService } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ClientsModule.registerAsync([
      {
        imports: [ConfigModule],
        name: 'ORDER',
        useFactory: (configService: ConfigService) => ({
          transport: Transport.TCP,
          options: {
            host: `${configService.get<string>('ORDER_HOST')}`,
            port: 3001
          }
        }),
        inject: [ConfigService]
      },

      {
        imports: [ConfigModule],
        name: 'INFO',
        useFactory: (configService: ConfigService) => ({
          transport: Transport.TCP,
          options: {
            host: `${configService.get<string>('INFO_HOST')}`,
            port: 3002
          }
        }),
        inject: [ConfigService]
      }
    ]),
  ],
  controllers: [AppController],
  providers: [AppService, ConfigService]
})
export class AppModule {}