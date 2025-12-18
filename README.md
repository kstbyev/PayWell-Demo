# PaywallDemo

Простое демо‑приложение на SwiftUI с онбордингом, paywall и сохранением состояния подписки через `UserDefaults` (`@AppStorage`).


## Скриншоты

### Главный Экран
<p align="center">
  <img src="https://github.com/user-attachments/assets/755e7317-3de6-4e47-8132-2b7c78ad03c6" width="200" alt="Splash Screen">
</p>

### Календарь Тренировк (Ноябрь)
<p align="center">
  <img src="https://github.com/user-attachments/assets/a9830e7f-f0c6-4261-b830-6417567f2b2e" width="200" alt="Splash Screen">
</p>

### Детали Тренировок с Датой
<p align="center">
  <img src="https://github.com/user-attachments/assets/45b2dde0-c0bc-460b-8871-5a5a1d92b437" width="200" alt="Splash Screen">
</p>

### График Пульса и Скорости
<p align="center">
  <img src="https://github.com/user-attachments/assets/5313a0e6-7179-4899-8c4d-36c33046018e" width="200" alt="Splash Screen">
</p>



## Стек

- Swift 5+
- SwiftUI
- UserDefaults (@AppStorage)
- NavigationStack / TabView / List

## Архитектура

Приложение максимально упрощено под формат тестового задания:

- `PaywallDemoApp`  
  Точка входа. Запускает `ContentView` в `WindowGroup`.

- `ContentView`  
  Корневой экран‑роутер.  
  На основе двух флагов в `@AppStorage` решает, что показать:
  - `isSubscribed` — куплена ли подписка.
  - `hasFinishedOnboarding` — завершён ли онбординг.

  Логика:
  - `isSubscribed == true` → сразу `MainView`.
  - `isSubscribed == false && hasFinishedOnboarding == true` → `PaywallView`.
  - Иначе → `OnboardingFlowView`.

- `OnboardingFlowView` / `OnboardingPageView`  
  2‑экранный онбординг (текст + простая иллюстрация).  
  Кнопка «Продолжить» листает страницы, на последней странице завершает онбординг (`hasFinishedOnboarding = true`).

- `PaywallView`  
  Экран с двумя тарифами: Месяц / Год (год с пометкой «Выгоднее»).  
  Кнопка «Продолжить»:
  - Эмулирует покупку с задержкой ~0.8 сек.
  - Показывает `ProgressView` и текст «Покупка…».
  - После «успеха» ставит `isSubscribed = true` → приложение переключается на `MainView`.
  - Повторные нажатия во время загрузки блокируются.

- `MainView`  
  Главный экран с `NavigationStack` и `List`:
  - Секция с примерным списком задач.
  - Секция «О приложении» с описанием логики.

  В тулбаре есть кнопка «Сбросить подписку» — сбрасывает `isSubscribed` и `hasFinishedOnboarding`, чтобы можно было снова пройти весь сценарий.

## Сохранение состояния

Для хранения состояния подписки и факта прохождения онбординга используется:

- `@AppStorage("isSubscribed")` → булев флаг в `UserDefaults`, переживает перезапуск приложения.
- `@AppStorage("hasFinishedOnboarding")` → флаг завершения онбординга.



## Что бы улучшил при большем времени

- Вынес бы состояние и бизнес‑логику в отдельный слой (например, `ViewModel` или простой `ObservableObject`), чтобы `View` были максимально «тонкими`.
- Разнёс бы экраны по отдельным файлам (`OnboardingFlowView.swift`, `PaywallView.swift`, `MainView.swift` и т.д.) для лучшей читаемости.
- Добавил бы:
  - UI‑тесты на сценарии: первый запуск / после подписки / сброс подписки.
  - Более реалистичный paywall: условия, ссылки на политику и оферту, пробный период.
  - Локализацию (RU/EN), поддержку тёмной темы и улучшенную доступность (Dynamic Type, VoiceOver).
- При интеграции реального биллинга — вынес бы работу с StoreKit в отдельный сервис/модуль.


# PayWell-Demo
