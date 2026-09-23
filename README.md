# Mint Cinnamon Themes

<p align="center">
  **Modern desktop themes for Linux Mint Cinnamon**<br>
  Windows 11 • macOS • ChromeOS
</p>

<p align="center">
  [![Linux Mint](https://img.shields.io/badge/Linux%20Mint-Cinnamon-87CF3E?style=for-the-badge&logo=linuxmint&logoColor=white)](https://linuxmint.com/)
  [![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
  [![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)
</p>

---

## ✨ Overview

**Mint Cinnamon Themes** is an interactive theme manager for **Linux Mint Cinnamon**.

It allows you to install desktop themes inspired by:
- 🪟 Windows 11
- 🍎 macOS
- 💻 ChromeOS

The project provides a simple and modern terminal interface for installing and removing themes and icon packs.
The installer downloads the required theme projects directly from their upstream Git repositories.

---

## 🚀 Quick Install

### Option 1 — One-line installer

Run:
```bash
curl -fsSL https://raw.githubusercontent.com/NottDevv/Mint-Cinnamon-Themes/main/install.sh | bash
```

### Option 2 — Download and inspect first

If you prefer to inspect the script before running it:
```bash
wget https://raw.githubusercontent.com/NottDevv/Mint-Cinnamon-Themes/main/install.sh
```

Then:
```bash
chmod +x install.sh
```

And run:
```bash
./install.sh
```

---

## 🎨 Available Themes

### 🪟 Windows 11
The Windows 11 option installs:
- Windows 11 inspired GTK theme
- Windows 11 icon theme
- Bold panel icons
- Cinnamon-compatible GTK styling

**Upstream projects:** [Win11 GTK Theme](https://github.com/yeyushengfan258/Win11-gtk-theme) | [Win11 Icon Theme](https://github.com/yeyushengfan258/Win11-icon-theme)  
*The Win11 GTK project supports GTK 3.20+ and provides multiple color, color-mode, size and tweak variants.*

### 🍎 macOS
The macOS option uses the WhiteSur project. It installs:
- WhiteSur GTK theme
- WhiteSur icon theme
- Light theme
- Dark theme
- macOS-inspired desktop appearance

**Upstream projects:** [WhiteSur GTK Theme](https://github.com/vinceliuice/WhiteSur-gtk-theme) | [WhiteSur Icon Theme](https://github.com/vinceliuice/WhiteSur-icon-theme)  
*WhiteSur provides support for multiple GTK-based desktop environments, including Cinnamon.*

### 💻 ChromeOS
The ChromeOS option installs:
- ChromeOS-inspired GTK theme
- Material-style desktop appearance
- ChromeOS-inspired icons

**Upstream projects:** [ChromeOS GTK Theme](https://github.com/vinceliuice/ChromeOS-theme) | [Ozone Icons](https://github.com/sakuhanaX3/Ozone-icons)

---

## 🛠️ Main Menu

When the installer starts, you will see:

```text
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║              MINT CINNAMON THEMES                          ║
║                                                            ║
║       Windows 11  •  macOS  •  ChromeOS                    ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝

             Theme Manager v1.1.0


  1  🎨  Install Themes
  2  🗑️  Uninstall Themes
  3  💾  Backup / Restore
  4  📊  Theme Status
  0  🚪  Exit
```

### 📦 Install Menu
Choose:
```text
  1  🪟  Windows 11
  2  🍎  macOS
  3  💻  ChromeOS
  4  🚀  Install ALL
  0  ←   Back
```

**Install ALL:** The option installs Windows 11, macOS (WhiteSur), and ChromeOS themes along with their respective icons.

### 🗑️ Uninstall Menu
You can remove themes individually:
```text
  1  🪟  Windows 11
  2  🍎  macOS / WhiteSur
  3  💻  ChromeOS
  4  🗑️  Remove ALL
  0  ←   Back
```
*The uninstall system is designed to remove only the theme families managed by this project. It does not intentionally remove Linux Mint's default themes.*

---

## 🖥️ Display Support
The project is designed to work with normal Full HD displays as well as higher-resolution displays supported by Cinnamon and the upstream themes. For a standard 1920×1080 Full HD laptop display, the installer uses normal theme variants rather than forcing high-DPI/4K-specific settings.

---

## 🔐 Safety
This project is a collection of shell scripts. Before running an internet-based installer, you should understand that shell scripts can execute commands on your system. If you prefer to inspect the code first, use:

```bash
wget https://raw.githubusercontent.com/NottDevv/Mint-Cinnamon-Themes/main/install.sh
less install.sh
chmod +x install.sh
./install.sh
```

---

## 📁 Project Structure
```text
Mint-Cinnamon-Themes/
│
├── install.sh
├── README.md
├── LICENSE
│
└── scripts/
    ├── common.sh
    ├── backup_restore.sh
    ├── windows11.sh
    ├── macos.sh
    ├── chromeos.sh
    └── uninstall.sh
```

---

## ⚖️ Licensing
The Mint Cinnamon Themes scripts are released under the MIT License. The upstream themes and icon packs have their own licenses. Please refer to each upstream repository for its individual license.

---

## 🤝 Contributing
Contributions are welcome. You can help by:
- Reporting bugs
- Suggesting new themes
- Improving the installer
- Improving Cinnamon integration
- Adding desktop layouts
- Improving documentation
- Testing on different Linux Mint versions

---

## 🐛 Bug Reports
If you encounter a problem, please open an issue and include:
- Linux Mint version
- Cinnamon version
- GPU model
- Display resolution
- Terminal output
- The theme you were installing

**Example:**
> Linux Mint: 22.x | Cinnamon: 6.x | GPU: NVIDIA GeForce 940MX | Resolution: 1920x1080 | Theme: Windows 11

---

## ⭐ Support the Project
If this project is useful to you, consider giving it a ⭐ on GitHub.  
**Repository:** [https://github.com/NottDevv/Mint-Cinnamon-Themes](https://github.com/NottDevv/Mint-Cinnamon-Themes)

---
---

<div dir="rtl" align="right">

# 🇮🇷 مستندات فارسی (Mint Cinnamon Themes)

این پروژه یک ابزار تعاملی برای نصب و مدیریت تم‌های مدرن روی **Linux Mint Cinnamon** است.

این ابزار ظاهرهایی الهام‌گرفته از سیستم‌عامل‌های زیر ارائه می‌کند:
- 🪟 **Windows 11**
- 🍎 **macOS**
- 💻 **ChromeOS**

هدف پروژه این است که نصب Theme و Icon Pack روی دسکتاپ Cinnamon تا حد ممکن ساده باشد و کاربر بتواند بدون نیاز به نصب دستی تعداد زیادی فایل و پیش‌نیاز، همه چیز را از طریق یک منوی ترمینال مدیریت کند.

## 🚀 نصب سریع

### روش اول — نصب سریع با یک دستور
در Terminal اجرا کنید:
```bash
curl -fsSL https://raw.githubusercontent.com/NottDevv/Mint-Cinnamon-Themes/main/install.sh | bash
```

### روش دوم — دانلود و بررسی قبل از اجرا
اگر ترجیح می‌دهید ابتدا اسکریپت را ببینید:
```bash
wget https://raw.githubusercontent.com/NottDevv/Mint-Cinnamon-Themes/main/install.sh
chmod +x install.sh
./install.sh
```

## 🎨 تم‌های موجود

### 🪟 Windows 11
شامل GTK Theme و Icon Theme شبیه ویندوز ۱۱ با آیکون‌های Bold برای پنل و سازگاری کامل با سینامون.

### 🍎 macOS
برای ظاهر مک‌اواس از پروژه معروف WhiteSur استفاده می‌شود که شامل تم‌های تیره، روشن و آیکون‌های استاندارد macOS است.

### 💻 ChromeOS
شامل تم متریال ChromeOS و آیکون‌های پروژه Ozone می‌باشد.

## 🛠️ ساختار منوها
اسکریپت پس از اجرا دارای گزینه‌های زیر است:
1. **Install Themes:** نصب تم‌ها (امکان انتخاب نصب تکی یا نصب همه).
2. **Uninstall Themes:** حذف هوشمند تم‌های نصب‌شده بدون آسیب به تم‌های پیش‌فرض سیستم.
3. **Backup / Restore:** تهیه نسخه پشتیبان از تنظیمات فعلی دسکتاپ شما.
4. **Theme Status:** بررسی وضعیت تم‌های نصب‌شده.

## 🔐 نکات امنیتی
این پروژه تماماً بر پایه Shell Script نوشته شده است. اگر نمی‌خواهید مستقیماً یک اسکریپت اینترنتی را اجرا کنید، می‌توانید فایل `install.sh` و سایر اسکریپت‌های پوشه `scripts` را قبل از اجرا با ویرایشگر متن بررسی کنید.

## ⭐ حمایت از پروژه
اگر این پروژه برای شما مفید بود، خوشحال می‌شوم در گیت‌هاب به آن ستاره (⭐) بدهید.

</div>
