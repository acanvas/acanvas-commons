library stagexl_commons;

@MirrorsUsed( metaTargets: const[Retain])
import 'dart:mirrors';

import 'dart:async' show Timer, Duration, Completer, StreamSubscription;
import 'dart:math';
import 'dart:html' as html;
import 'dart:js' as js;

/* Rockdot Commons depend on StageXL, especially its Event system */
import 'package:stagexl/stagexl.dart';
/* required by Logger */
import 'package:logging/logging.dart' as logging;


//async
part 'src/async/operation/impl/abstract_operation.dart';
part 'src/async/operation/impl/load_urloperation.dart';
part 'src/async/operation/impl/abstract_progress_operation.dart';
part 'src/async/operation/impl/operation_queue.dart';
part 'src/async/command/composite_command_kind.dart';
part 'src/async/command/i_async_command.dart';
part 'src/async/command/i_command.dart';
part 'src/async/command/i_composite_command.dart';
part 'src/async/command/event/command_event.dart';
part 'src/async/command/event/composite_command_event.dart';
part 'src/async/operation/model/urlloader_data_format.dart';
part 'src/async/operation/i_operation.dart';
part 'src/async/operation/i_operation_queue.dart';
part 'src/async/operation/i_progress_operation.dart';
part 'src/async/operation/event/operation_event.dart';
//data
part 'src/data/i_data_proxy.dart';
part 'src/data/rockdot_vo.dart';
//eventbus
part 'src/eventbus/i_event_bus.dart';
part 'src/eventbus/i_event_bus_aware.dart';
part 'src/eventbus/i_event_bus_listener.dart';
part 'src/eventbus/i_simple_event_bus.dart';
part 'src/eventbus/impl/dart_event_bus.dart';
part 'src/eventbus/impl/rockdot_event.dart';
//lang
part 'src/lang/assert.dart';
part 'src/lang/util/ordered_utils.dart';
part 'src/lang/class_utils.dart';
part 'src/lang/illegal_argument_error.dart';
part 'src/lang/string_utils.dart';
part 'src/lang/i_disposable.dart';
part 'src/lang/i_cloneable.dart';
part 'src/lang/i_ordered.dart';
//logging
part 'src/logging/logger.dart';
//mirror
part 'src/mirror/retain.dart';
//util
part 'src/util/context_tool.dart';
part 'src/util/device_detector.dart';
part 'src/util/font_tool.dart';
part 'src/util/graphics_util.dart';
part 'src/util/numeric_stepper.dart';

//view:basics
part 'src/view/component/i_sprite_component.dart';
part 'src/view/component/sprite_component.dart';
part 'src/view/component/i_managed_sprite_component.dart';
part 'src/view/component/managed_sprite_component.dart';
part 'src/view/component/managed_sprite_component_event.dart';
//view:components
part 'src/view/component/flick_image.dart';

part 'src/view/component/form/calendar/calendar.dart';
part 'src/view/component/form/calendar/day_button.dart';
part 'src/view/component/form/calendar/next_prev_button.dart';

part 'src/view/component/common/box/accordeon/accordion.dart';
part 'src/view/component/common/box/accordeon/accordion_cell.dart';
part 'src/view/component/common/box/hbox.dart';
part 'src/view/component/common/box/hbox_animated.dart';
part 'src/view/component/common/box/vbox.dart';
part 'src/view/component/common/box/vbox_animated.dart';

part 'src/view/component/common/component_bitmap_data.dart';
part 'src/view/component/common/component_image_loader.dart';
part 'src/view/component/common/component_scrollable.dart';
part 'src/view/component/common/keyboard.dart';
part 'src/view/component/common/scrollable/event/scroll_view_event.dart';
part 'src/view/component/common/scrollable/event/slider_event.dart';
part 'src/view/component/common/scrollable/orientation.dart';
part 'src/view/component/common/scrollable/default_scrollbar.dart';
part 'src/view/component/common/scrollable/scrollbar.dart';
part 'src/view/component/common/scrollable/slider.dart';

part 'src/view/component/form/button/cell.dart';
part 'src/view/component/form/button/button.dart';
part 'src/view/component/form/button/radio_button.dart';
part 'src/view/component/form/button/radio_group_event.dart';
part 'src/view/component/form/button/radio_group_h.dart';
part 'src/view/component/form/button/radio_group_v.dart';
part 'src/view/component/form/button/toggle_button.dart';
part 'src/view/component/form/button/toggle_button_event.dart';

part 'src/view/component/form/component_dropdown.dart';
part 'src/view/component/form/component_list.dart';
part 'src/view/component/form/component_pager.dart';
part 'src/view/component/form/component_with_data_proxy.dart';
//view:effect
part 'src/view/effect/i_effect.dart';
part 'src/view/effect/no_effect.dart';
part 'src/view/effect/basic_effect.dart';
//view:textfield
part 'src/view/textfield/ui_text_field.dart';
part 'src/view/textfield/ui_text_field_input.dart';
//view:book
part 'src/view/component/book/book_view.dart';
part 'src/view/component/book/book_sample_assets.dart';
part 'src/view/component/book/containers/super_view_stack.dart';
part 'src/view/component/book/drawing/drawing_tool.dart';
part 'src/view/component/book/drawing/line_style.dart';
part 'src/view/component/book/flashsandy/distort_image.dart';
part 'src/view/component/book/foxaweb/page_flip.dart';
part 'src/view/component/book/geom/geom.dart';
part 'src/view/component/book/geom/infinite_line.dart';
part 'src/view/component/book/geom/line.dart';
part 'src/view/component/book/geom/super_point.dart';
part 'src/view/component/book/geom/super_rectangle.dart';
part 'src/view/component/book/index_changed_event.dart';
part 'src/view/component/book/managers/state_manager.dart';
part 'src/view/component/book/utils/array_tool.dart';
part 'src/view/component/book/utils/child_tool.dart';
part 'src/view/component/book/utils/math_tool.dart';
part 'src/view/component/book/view/book_error.dart';
part 'src/view/component/book/view/book_event.dart';
part 'src/view/component/book/view/gradients.dart';
part 'src/view/component/book/view/page.dart';
part 'src/view/component/book/view/page_manager.dart';
//view:video
//part 'src/view/component/video/video_controls.dart';
//part 'src/view/component/video/video_player.dart';
//view:paper
part 'src/view/paper/common/i_paper_button_component.dart';
part 'src/view/paper/common/paper_color.dart';
part 'src/view/paper/common/paper_list_cell.dart';
part 'src/view/paper/common/paper_ripple.dart';
part 'src/view/paper/common/paper_shadow.dart';
part 'src/view/paper/common/paper_input.dart';
part 'src/view/paper/common/paper_text.dart';
part 'src/view/paper/common/icon/paper_icon_set.dart';
part 'src/view/paper/common/icon/paper_icon.dart';
part 'src/view/paper/common/icon/svg_display_object.dart';
part 'src/view/paper/paper_button.dart';
part 'src/view/paper/paper_button_round.dart';
part 'src/view/paper/paper_dialog.dart';
part 'src/view/paper/paper_menu.dart';

