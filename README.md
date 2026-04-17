
## App Demo

> video for App " https://drive.google.com/file/d/10Nsd-2CtwGVvHY3FxBfzWPPdKIYKqsSg/view?usp=sharing "


## Animation Research & Implementation

1. *Implicit animations* 
        are prebuilt animation effects that run the entire animation automatically. When the target value of the animation changes, it runs the animation from the current value to the target value, and displays each value in between so that the widget animates smoothly. Examples of implicit animations include AnimatedSize, AnimatedScale, and AnimatedPositioned.

---

2. *Explicit Animations*
        These provide full control over the animation. They require an `AnimationController` to start, stop, or reverse the animation.
        Examples include SizeTransition, ScaleTransition or PositionedTransition.


---

3. *Hero Animations*
        are implemented using two Hero widgets: one describing the widget in the source route, and another describing the widget in the destination route. From the user's point of view, the hero appears to be shared, and only the programmer needs to understand this implementation detail.
        
 *       Hero animation code has the following structure:

        Define a starting Hero widget, referred to as the source hero. The hero specifies its graphical representation (typically an image), and an identifying tag, and is in the currently displayed widget tree as defined by the source route.

        Define an ending Hero widget, referred to as the destination hero. This hero also specifies its graphical representation, and the same tag as the source hero. It's essential that both hero widgets are created with the same tag, typically an object that represents the underlying data. For best results, the heroes should have virtually identical widget trees.

        Create a route that contains the destination hero. The destination route defines the widget tree that exists at the end of the animation.
        Trigger the animation by pushing the destination route on the Navigator's stack. The Navigator push and pop operations trigger a hero animation for each pair of heroes with matching tags in the source and destination routes.


-----------------------------------------------------------------------------------------------------------------

## Most Common Implicit Animation Widgets


1. **AnimatedContainer:**

The most versatile implicit animation widget.

It can animate almost every property of a standard Container, including width, height, color, borderRadius, and padding.


*Use Case:* Changing the color or size of a "Category Card" when a user selects it.

2. **AnimatedOpacity:**

Used to animate the transparency of a child widget.

It transitions smoothly between a given opacity value (from 0.0 to 1.0).


*Use Case:* Fading in the "Next Question" button only after the user has selected an answer.

3. **AnimatedSwitcher:**

Used when you want to switch between two different widgets with a transition.

By default, it uses a cross-fade effect when the child widget changes.


*Use Case:* Switching between the text of the current question and the next question in the Quiz screen.

4. **AnimatedPadding:**

Automatically animates the transition of a widget's padding.


*Use Case:* Expanding the space around a selected answer to highlight it.

5. **AnimatedPositioned:**

Used within a Stack to animate a widget's position (Top, Bottom, Left, Right).


*Use Case:* Moving a "Bonus Points" badge across the screen when a user answers correctly.

-------------------------------------------------------------------------------------------------------------------

## PageRouteBuilder

The PageRouteBuilder is a powerful class in Flutter used to create custom page transitions.
gives you full control over how a new screen enters and exits the view.

*PageRouteBuilder is the primary way to implement Explicit Animations for navigation.*

 >> It works by defining two main functions:

    1. pageBuilder: This builds the actual widget (the destination screen).

    2. transitionsBuilder: This defines the animation (the motion) that happens during the transition.

-------------------------------------------------------------------------------------------------------------------

## Project Overview: Brainy Quiz App

Brainy is an interactive mobile application built using Flutter and Dart, designed to make learning and testing knowledge a fun and seamless experience. The app allows users to either participate in existing quizzes or create their own, fostering a collaborative learning environment.

*Key Features*:

* Custom Quiz Creation: 
        Users can design their own quizzes by adding questions, multiple-choice answers, and assigning specific points to each question to define its difficulty.

* Dynamic Code Generation:
        Every newly created quiz is assigned a unique 6-character code, allowing users to share their quizzes with others instantly.

* Categorized Exploration:
        Quizzes are organized into categories (e.g., Programming, History, Science), making it easy for users to find topics they are interested in.

* User Personalization: 
        A dedicated login system that welcomes users by name and tracks their progress across the application.


# Technical Implementation:

* Navigation: 
        Implements a multi-screen flow (5+ screens) using AnimatedNotchBottomBar and PageView for professional navigation.


* Responsive Design: 
        We utilized MediaQuery and flexible widgets like Expanded and SingleChildScrollView to ensure the application maintains a consistent layout across different screen ratios and avoids pixel overflows during keyboard interactions.


* OOP Principles: 
        Uses structured Data Models (e.g., QuizQuestion, Category) to manage application state and data flow effectively.

# Technical Stack & Database Architecture

We built the core logic of Brainy using a robust local data management system:

* Flutter & Dart: The main framework for the UI and logic.

* Sqflite: Our primary Relational Database (RDBMS) for structured data (Users, Quizzes, Questions).

* Shared Preferences: Used for Session Management to keep the user logged in.

* Path & Path Provider: To manage safe and cross-platform internal storage paths for the database file.

* Data Model Logic:

We followed a Normalization approach to organize data across 6 interconnected tables:

**Identity:** users table for authentication.

**Hierarchy:** categories ➔ quizzes ➔ questions ➔ options.

**Analytics:** attempts table to track progress and scores.

* Key Performance Features:

# SQL Transactions: Ensures a quiz is saved only if all its questions/options are valid.

# Optimized Aggregation: Total points are calculated using SQL SUM for maximum efficiency.

# Static State Caching: Syncing the database score with the UI once at login to provide a seamless, lag-free experience.
