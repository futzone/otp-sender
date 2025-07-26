# 📲 SMS OTP Sender

## 📌 Muqaddima

Mobil ilovalar, websaytlar, Telegram botlardan ro’yxatdan o’tish jarayonida foydalanuvchilarning telefon raqamini tasdiqlash uchun shu telefon raqamga tasdiqlash kodi — ya’ni **“OTP kod”** yuboriladi. 

Buning uchun odatda SMS yuborish provayderlari bilan shartnoma imzolashingiz kerak bo’ladi. Shartnoma uchun esa yuridik shaxs yoki yakka tartibdagi tadbirkor bo’lishingiz lozim. Ustiga-ustak yana ancha to’lovlari ham bor.

Bu esa yangi loyihalar uchun jiddiy “bosh og’rig’i”. Biz esa bu muammoni yechishga harakat qildik va uddasidan chiqdik, degan umiddamiz!

---

## ⚙️ Qanday ishlaydi?

Tizimning ishlash tamoyili juda oddiy:

1. Mobil ilovani telefoningizga o‘rnatasiz.
2. Ilova siz belgilagan `GET` API orqali OTP ma’lumotlarini olib keladi.
3. Ushbu kodlar sizning telefon raqamingizdan foydalanuvchiga SMS orqali yuboriladi.
4. SMS yuborilgach, `POST` API orqali sizning bazangizga tasdiq xabari yuboriladi.

---

## 🪜 Qadamlar

### 1. `GET` method (kodlarni olish)

```json
[
  {
    "phone": "+998912345678",
    "code": "12345"
  },
  {
    "phone": "+998912345687",
    "code": "12367"
  }
]
````

Agar authorization kerak bo‘lsa:

```json
{
  "Authorization": "Bearer YOUR_TOKEN"
}
```

---

### 2. `POST` method (yuborilgan kodni qayd qilish)

URL ko’rinishi:

```
POST https://your-api.com/success-endpoint/+998912345678
```

Authorization kerak bo‘lsa:

```json
{
  "Authorization": "Bearer YOUR_TOKEN"
}
```

---

## 📲 Ilovani o’rnatish

Ilova **faqat Android** qurilmalarda ishlaydi.

1. Ilovani yuklab oling: \[Yuklab olish havolasi]
2. Ruxsatlar (SMS yuborish/o‘qish) berilishi shart
3. Quyidagi maydonlarni to‘ldiring:

* `Interval` – GET so‘rov yuboriladigan soniyalar oralig‘i
* `Get request URL` – Kodlar ro‘yxatini qaytaruvchi endpoint
* `Post request URL` – Yuborilgan kod uchun bildirishnoma URL
* `Headers` – (Agar kerak bo‘lsa) Authorization token

---

## 🔐 Xavfsizlik

Ilova hech qanday zararli kodga ega emas va ma’lumotlaringizni yig‘maydi. Yanada ishonch uchun ochiq kodni ko‘rishingiz mumkin: \[GitHub manbasi]

---

## 📎 Eslatma

* `GET`, `POST` methodlari qat’iy JSON formatida bo‘lishi lozim.
* Juda ko‘p SMS yuborish raqamingiz operatori tomonidan bloklanishiga olib kelishi mumkin. Real loyihalarda ehtiyotkorlik bilan foydalaning!

---

## 🔜 Tez orada

✅ WebSocket integratsiyasi — tizimni real-vaqtli va tezkor qilish uchun qo‘shiladi.

---

## 📮 Aloqa

Agar xatoliklar, takliflar bo‘lsa — GitHub Issues yoki Telegram orqali bog‘laning.

---

© qahorovz 2024 — Barcha huquqlar himoyalangan
