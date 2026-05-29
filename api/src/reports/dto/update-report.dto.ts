import { PartialType } from '@nestjs/mapped-types';
import { ReportStatus } from '@prisma/client';
import { IsEnum, IsOptional, IsString, MinLength } from 'class-validator';
import { CreateReportDto } from './create-report.dto';

export class UpdateReportDto extends PartialType(CreateReportDto) {
  @IsOptional()
  @IsString()
  @MinLength(5)
  title?: string;

  @IsOptional()
  @IsString()
  @MinLength(10)
  description?: string;

  @IsOptional()
  @IsString()
  @MinLength(3)
  location?: string;

  @IsOptional()
  @IsEnum(ReportStatus)
  status?: ReportStatus;
}
