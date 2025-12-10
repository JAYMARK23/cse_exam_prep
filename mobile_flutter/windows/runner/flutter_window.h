#ifndef RUNNER_FLUTTER_WINDOW_H_
#define RUNNER_FLUTTER_WINDOW_H_

#include <memory>

#include "win32_window.h"

// NOTE:
// - This header intentionally avoids including Flutter engine headers to prevent
//   IDE/IntelliSense include-path errors when the Flutter SDK/engine headers are
//   not available to the editor. The corresponding .cpp file must include the
//   real Flutter headers (<flutter/dart_project.h> and
//   <flutter/flutter_view_controller.h>) so that full types are available at
//   implementation time.
// - Because the DartProject is stored as a reference here, the caller must
//   ensure the referenced object outlives this FlutterWindow instance.

// Forward declarations to avoid requiring Flutter include paths in this header.
namespace flutter {
class DartProject;
class FlutterViewController;
}

// A window that does nothing but host a Flutter view.
class FlutterWindow : public Win32Window {
 public:
  // Creates a new FlutterWindow hosting a Flutter view running |project|.
  explicit FlutterWindow(const flutter::DartProject& project);
  virtual ~FlutterWindow();

 protected:
  // Win32Window:
  bool OnCreate() override;
  void OnDestroy() override;
  LRESULT MessageHandler(HWND window, UINT const message, WPARAM const wparam,
                         LPARAM const lparam) noexcept override;

 private:
  // The project to run (stored by value to own lifetime).
  flutter::DartProject project_;

  // The Flutter instance hosted by this window.
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
};

#endif  // RUNNER_FLUTTER_WINDOW_H_
