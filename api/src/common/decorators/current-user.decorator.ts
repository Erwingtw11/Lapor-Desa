import { ExecutionContext, createParamDecorator } from '@nestjs/common';
import { RequestUser } from '../interfaces/request-user.interface';

export const CurrentUser = createParamDecorator(
  (_data: unknown, ctx: ExecutionContext): RequestUser | undefined => {
    const request = ctx.switchToHttp().getRequest();
    return request.user as RequestUser | undefined;
  },
);
