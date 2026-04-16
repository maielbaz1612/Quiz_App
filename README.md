## Animation Research & Implementation

1. Implicit Animations
These are the simplest way to add animations. We use them when we want to animate a widget's property (like color, size, or opacity) without managing an `AnimationController`.

 **What we learned:** They are "set-and-forget" widgets. When the property value changes, Flutter handles the transition smoothly.
 **Implementation:** Used in the **Submit Button** and **Category Cards** to create a smooth scale and color effect when interacted with.
 **Reference:** [Flutter Docs - Implicit Animations](https://docs.flutter.dev/ui/animations/implicit-animations)

---

2. Explicit Animations
These provide full control over the animation. They require an `AnimationController` to start, stop, or reverse the animation.

 **What we learned:** They are used for complex animations that need to be controlled manually or repeat indefinitely.
 **Implementation:** Studied for controlling custom transitions and timed sequences.
 **Reference:** [Flutter Docs - Explicit Animations](https://docs.flutter.dev/ui/animations/explicit-animations)

---

3. Hero Animations
A special type of animation that "flies" a widget from one screen to another during navigation.

 **What we learned:** It connects two different screens by sharing a common widget with a unique `tag`.
 **Implementation:** Used to animate the **Category Icon** from the `Home Screen` to the `Quiz Screen` to provide a seamless visual flow.
 **Reference:** [Flutter Docs - Hero Animations](https://docs.flutter.dev/ui/animations/hero-Animations)

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


## App Demo
>