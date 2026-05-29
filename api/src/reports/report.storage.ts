import { BadRequestException } from '@nestjs/common';
import { MulterOptions } from '@nestjs/platform-express/multer/interfaces/multer-options.interface';
import { diskStorage } from 'multer';
import { extname } from 'path';

const allowedExtensions = new Set(['.jpg', '.jpeg', '.png']);

export const reportUploadOptions: MulterOptions = {
  storage: diskStorage({
    destination: './uploads',
    filename: (_request, file, callback) => {
      const uniqueName = `${Date.now()}-${Math.round(Math.random() * 1e9)}${extname(
        file.originalname,
      ).toLowerCase()}`;

      callback(null, uniqueName);
    },
  }),
  limits: {
    fileSize: 2 * 1024 * 1024,
  },
  fileFilter: (_request, file, callback) => {
    const extension = extname(file.originalname).toLowerCase();

    if (!allowedExtensions.has(extension)) {
      callback(
        new BadRequestException('File harus berupa JPG, JPEG, atau PNG.'),
        false,
      );
      return;
    }

    callback(null, true);
  },
};
