import { Role } from '@prisma/client';

export interface RequestUser {
  id: number;
  email: string;
  name: string;
  role: Role;
}
