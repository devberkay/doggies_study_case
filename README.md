# doggies_study_case

This study case has been prepared by Berkay Can to showcase certain threshold skills of Flutter Development:

## YouTube showcase

<div align="left" >
      <a href="https://www.youtube.com/watch?v=7qupapbfnU8">
         <img src="https://img.youtube.com/vi/7qupapbfnU8/0.jpg" style="width:100%;">
      </a>
</div>

## Instructions

**Flutter Developer Case Study![](Aspose.Words.b555fbbd-d49a-4ef6-a532-0d9cb3d49fde.002.png)**


*\*\*Proje direkt olarak çalıştırılabilir olmalıdır.*

*\*\*Bilmemiz gereken ekstra detayları README içerisinde belirtebilirsin.*

*\*\*Bloc kullanmalısın ancak Cubit kullanılmayacak.*

*\*\*Routing sistemi kullanmalısın.*


- *Linkteki dosyayı bilgisayarına indir.*
- [***figma.com** s](http://www.figma.com)*itesine git ve giriş yap.*
- *Sağ üst köşedeki **Import** butonuna tıkla.*
- ***From your computer** butonuna tıkla.*
- *İndirdiğin dosyayı seç ve **Open** butonuna tıkla.*

*\*\*Dog API [Link*](https://dog.ceo/dog-api/documentation/)*

**Test Projesi:**

- Flutter ile üstte yer alan Figma projesindeki dizayn ile beraber, Dog API’yi kullanarak bir uygulama yapmanı bekliyoruz.
- Figma tasarımını birebir uygulamanı istiyoruz ancak yapamadığın ya da eksik kalan bir kısım olursa bunları README içerisinde veya çalışmanı ilettiğin mailde belirtmelisin.
- Dog API içerisinde gerekli tüm dökümantasyon mevcut. Aşağıda uygulama sürecini anlattığımız bölümde hangi kısım için hangi endpointi kullanman gerektiğini anlayabilirsin.

**Uygulama süreci:**

*\*\*Bu açıklamanın yanı sıra Figma’da sağ üstte bulunan Run ikonuyla beraber prototipi çalıştırıp appin nasıl çalışması gerektiğine göz atabilirsin.*

![](Aspose.Words.b555fbbd-d49a-4ef6-a532-0d9cb3d49fde.003.png)

- App bir splash screen ile açılacak ve bu ekranda API’den tüm köpek türleri ve bu türlere ait birer resim linki çekilene kadar kalacak. Köpek türleri çekildikten sonra resimler **paralel** olarak çekilecek.

  *\*\*Resimler splash’te cache’e alınmalı, ana ekran açıldığı anda herhangi bir resim geç yüklenmemeli, anında görülmeli.*

- Ana ekranda, üstte basit bir app bar ve aşağıda bir bottom bar olacak. Kullanıcı bottom barda anasayfayı ve ayarlar ekranını açabilecek.
- Anasayfada:
- Köpek cinsleri, fotoğrafları ve cins isimleri ile listelenecek. Bottom barın üstünde yer alan input ile bu cinsler filtrelenebilecek.
- Input kaydırılıp uzatılabilir olmalı. Bu inputun örnek kullanımı için **Genie** ya da **Slack** uygulamalarına bakabilirsin. Aynı zamanda prototipte de uygun kullanımı görebilirsin.
- Ögelere tıklandığında bottom sheet çıkacak ve **Generate** butonu ile beraber

  o cinse ait random bir fotoğraf generate edilip kullanıcıya Figma’daki gibi gösterilecek.

- Ayarlarda:
- İşletim sistemi versiyon kısmı, **herhangi bir paket kullanılmadan,** native olarak ios ve android klasörlerinde yazılan **native kodlar ile Method Channel kullanılarak** çekilip burada gösterilecek. Örnek: iOS 16.2, Android 13
- Diğer kısımlar için fonksiyonellik eklemene gerek yok, UI yeterli olacak.




## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
