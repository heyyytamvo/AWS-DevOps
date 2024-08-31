import { Entity, Column, PrimaryColumn } from 'typeorm';

@Entity()
export class Order {
  @PrimaryColumn()
  name: string;

  @Column()
  age: number;
}