# ped-pig for FiveM

## Mục đích
Resource này thêm ped con heo (pig) vào server FiveM.

## Cài đặt
1. Đặt folder `ped-pig` vào thư mục `[qb]` hoặc resource bất kỳ.
2. Đảm bảo có các file:
   - fxmanifest.lua
   - peds.meta
   - stream/a_c_pig.ydd
   - stream/a_c_pig.yft
   - stream/a_c_pig.ymt
   - stream/a_c_pig.ytd
3. Trong `server.cfg`, đảm bảo có dòng:
   ```
   ensure [qb]
   ```
   hoặc nếu để ngoài, dùng:
   ```
   ensure ped-pig
   ```

## Sử dụng
- Vào game, dùng lệnh hoặc script để spawn ped với tên model: `a_c_pig`.
- Ví dụ lệnh: `/spawnped a_c_pig` (nếu có resource hỗ trợ lệnh này).
- Hoặc dùng script client-side để spawn ped.

## Thông tin thêm
- File `peds.meta` đã cấu hình sẵn cho model `a_c_pig`.
- Các file trong thư mục `stream` là model 3D và texture của con heo.

Nếu gặp lỗi hoặc cần hỗ trợ, hãy liên hệ mình để sửa lỗi.
