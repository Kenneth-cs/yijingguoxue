---
name: Tracking Implementation Plan
overview: Implement the EventTracker singleton and integrate the required analytics events across the app according to the tracking plan.
todos:
  - id: create-event-tracker
    content: Create Core/Utilities/EventTracker.swift
    status: pending
  - id: implement-app-launch
    content: Implement app_launch in MainTabView / App.swift
    status: pending
  - id: implement-wiki-events
    content: Add wiki_view_page and wiki_click_article to EncyclopediaView
    status: pending
  - id: implement-practice-entrance
    content: Add game_click_entrance to PracticeView
    status: pending
  - id: implement-game-service-events
    content: Add game_start_training and game_finish_training to GameService
    status: pending
  - id: implement-home-banner-event
    content: Add home_click_banner to HomeView
    status: pending
  - id: implement-practice-banner-event
    content: Add practice_click_banner to PracticeView
    status: pending
isProject: false
---

# 易经国学堂 Data Tracking Implementation Plan

This plan details the implementation of the analytics specifications defined in `易经国学堂埋点方案.md`. We will implement a centralized `EventTracker` singleton and integrate the required tracking events at key points in the app's architecture.

## Implementation Steps

*   **Create EventTracker Service**
    *   Create a new file `易经国学堂/Core/Utilities/EventTracker.swift`.
    *   Implement the `EventTracker` singleton class exactly as specified in the markdown documentation, including `deviceId` and `currentUserId` generation, and the `trackEvent` method with API details.

*   **Implement Foundation & Lifecycle Tracking**
    *   Modify `[易经国学堂/_____App.swift](易经国学堂/_____App.swift)` or `MainTabView` to trigger `app_launch` when the app appears. 

*   **Implement Wiki & Encyclopedia Tracking**
    *   Modify `[易经国学堂/Features/Encyclopedia/Views/EncyclopediaView.swift](易经国学堂/Features/Encyclopedia/Views/EncyclopediaView.swift)` to track `wiki_view_page` in the `.onAppear` modifier.
    *   In the same file, add a `.simultaneousGesture(TapGesture().onEnded { ... })` modifier to the `NavigationLink` for hexagrams and trigrams to trigger `wiki_click_article` with the relevant `article_id`, `article_name`, and `category` parameters.

*   **Implement Game & Practice Tracking**
    *   Modify `[易经国学堂/Features/Practice/Views/PracticeView.swift](易经国学堂/Features/Practice/Views/PracticeView.swift)` to trigger `game_click_entrance` by adding a `.simultaneousGesture` to the NavigationLinks for the four specific games.
    *   Modify `[易经国学堂/Core/Services/GameService.swift](易经国学堂/Core/Services/GameService.swift)` to track the game lifecycle:
        *   In `startGame()`, add the `game_start_training` event with the `game_type`.
        *   In `endGame()`, calculate the elapsed time and trigger `game_finish_training` with the `game_type`, `score`, and `duration_sec`.

*   **Implement Banner Tracking**
    *   Modify `[易经国学堂/Features/Home/Views/HomeView.swift](易经国学堂/Features/Home/Views/HomeView.swift)`: Wrap the `welcomeBanner` image with a `Button` or add `.onTapGesture` to trigger the `home_click_banner` event.
    *   Modify `[易经国学堂/Features/Practice/Views/PracticeView.swift](易经国学堂/Features/Practice/Views/PracticeView.swift)`: In the `openCoachApp` method (or inside the Button action), add the `practice_click_banner` tracking event.