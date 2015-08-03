library stagexl_commons;

import 'dart:async' show Timer, Duration, Completer, StreamSubscription, Zone;
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
part 'src/data/i_xl_vo.dart';
part 'src/data/i_xl_dto.dart';
//eventbus
part 'src/eventbus/i_event_bus.dart';
part 'src/eventbus/i_event_bus_aware.dart';
part 'src/eventbus/i_event_bus_listener.dart';
part 'src/eventbus/i_simple_event_bus.dart';
part 'src/eventbus/impl/xl_event_bus.dart';
part 'src/eventbus/impl/xl_signal.dart';
//lang
part 'src/lang/assert.dart';
part 'src/lang/util/ordered_utils.dart';
//part 'src/lang/class_utils.dart';
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
part 'src/util/key_code.dart';
part 'src/util/numeric_stepper.dart';

//view base: box, behave, lifecycle
part 'src/view/base/m_box.dart';
part 'src/view/base/m_behave.dart';
part 'src/view/base/m_lifecycle.dart';
part 'src/view/base/lifecycle_event.dart';
part 'src/view/base/impl/box_sprite.dart';
part 'src/view/base/impl/behave_sprite.dart';
part 'src/view/base/impl/lifecycle_sprite.dart';
part 'src/view/base/impl/image_sprite.dart';

part 'src/view/calendar/calendar.dart';
part 'src/view/calendar/day_button.dart';
part 'src/view/calendar/next_prev_button.dart';

part 'src/view/flow/m_flow.dart';
part 'src/view/flow/m_duration.dart';
part 'src/view/flow/impl/flow.dart';
part 'src/view/flow/impl/accordeon.dart';

part 'src/view/interact/button/m_button.dart';
part 'src/view/interact/button/m_selectable.dart';
part 'src/view/interact/button/radio_group_event.dart';
part 'src/view/interact/button/impl/button.dart';
part 'src/view/interact/button/impl/selectable_button.dart';
part 'src/view/interact/button/impl/radio_group.dart';

part 'src/view/interact/list/m_list.dart';
part 'src/view/interact/list/m_pager.dart';
part 'src/view/interact/list/impl/list_sprite.dart';
part 'src/view/interact/list/impl/pager_sprite.dart';
part 'src/view/interact/list/impl/dropdown.dart';

part 'src/view/interact/scroll/m_paged_scroll.dart';
part 'src/view/interact/scroll/m_scroll.dart';
part 'src/view/interact/scroll/scrollify_event.dart';
part 'src/view/interact/scroll/impl/scrollbar.dart';
part 'src/view/interact/scroll/impl/default_scrollbar.dart';
part 'src/view/interact/scroll/impl/scrollify_sprite.dart';
part 'src/view/interact/scroll/impl/wrap.dart';

part 'src/view/interact/slider/m_slider.dart';
part 'src/view/interact/slider/slider_event.dart';
part 'src/view/interact/slider/impl/slider.dart';

//view/keyboard
part 'src/view/keyboard/char_code.dart';
part 'src/view/keyboard/key.dart';
part 'src/view/keyboard/key_event.dart';
part 'src/view/keyboard/key_row.dart';
part 'src/view/keyboard/label.dart';
part 'src/view/keyboard/callout.dart';
part 'src/view/keyboard/layouts/azerty.dart';
part 'src/view/keyboard/layouts/azerty_fr.dart';
part 'src/view/keyboard/layouts/azerty_switch.dart';
part 'src/view/keyboard/layouts/azerty_switch_fr.dart';
part 'src/view/keyboard/layouts/email_numbers_symbols_switch.dart';
part 'src/view/keyboard/layouts/email_switch.dart';
part 'src/view/keyboard/layouts/layout.dart';
part 'src/view/keyboard/layouts/numbers_symbols.dart';
part 'src/view/keyboard/layouts/numbers_symbols_switch.dart';
part 'src/view/keyboard/layouts/num_pad.dart';
part 'src/view/keyboard/layouts/num_pad_operators.dart';
part 'src/view/keyboard/layouts/qwerty.dart';
part 'src/view/keyboard/layouts/qwerty_fr.dart';
part 'src/view/keyboard/layouts/qwerty_switch.dart';
part 'src/view/keyboard/layouts/qwerty_switch_fr.dart';
part 'src/view/keyboard/soft_keyboard.dart';

//view:experimental
part 'src/view/experimental/flick_image.dart';
//view:book
part 'src/view/experimental/book/book_view.dart';
part 'src/view/experimental/book/book_sample_assets.dart';
part 'src/view/experimental/book/containers/super_view_stack.dart';
part 'src/view/experimental/book/drawing/drawing_tool.dart';
part 'src/view/experimental/book/drawing/line_style.dart';
part 'src/view/experimental/book/flashsandy/distort_image.dart';
part 'src/view/experimental/book/foxaweb/page_flip.dart';
part 'src/view/experimental/book/geom/geom.dart';
part 'src/view/experimental/book/geom/infinite_line.dart';
part 'src/view/experimental/book/geom/line.dart';
part 'src/view/experimental/book/geom/super_point.dart';
part 'src/view/experimental/book/geom/super_rectangle.dart';
part 'src/view/experimental/book/index_changed_event.dart';
part 'src/view/experimental/book/managers/state_manager.dart';
part 'src/view/experimental/book/utils/array_tool.dart';
part 'src/view/experimental/book/utils/child_tool.dart';
part 'src/view/experimental/book/utils/math_tool.dart';
part 'src/view/experimental/book/view/book_error.dart';
part 'src/view/experimental/book/view/book_event.dart';
part 'src/view/experimental/book/view/gradients.dart';
part 'src/view/experimental/book/view/page.dart';
part 'src/view/experimental/book/view/page_manager.dart';
//view:video
//part 'src/view/component/video/video_controls.dart';
//part 'src/view/component/video/video_player.dart';


//view:effect
part 'src/view/effect/i_effect.dart';
part 'src/view/effect/no_effect.dart';
part 'src/view/effect/basic_effect.dart';
part 'src/view/effect/center_zoom_transition.dart';
//part 'src/view/effect/hflip_transition.dart';
part 'src/view/effect/hleft_swipe_transition.dart';
part 'src/view/effect/hright_swipe_transition.dart';
//view:textfield
part 'src/view/textfield/ui_text_field.dart';
part 'src/view/textfield/ui_text_field_input.dart';
//view:paper
part 'src/view/paper/common/i_paper_button_component.dart';
part 'src/view/paper/common/paper_color.dart';
part 'src/view/paper/common/paper_list_cell.dart';
part 'src/view/paper/common/paper_ripple.dart';
part 'src/view/paper/common/paper_shadow.dart';
part 'src/view/paper/common/paper_progress.dart';
part 'src/view/paper/common/paper_text.dart';
part 'src/view/paper/common/icon/paper_icon_set.dart';
part 'src/view/paper/common/icon/paper_icon.dart';
part 'src/view/paper/common/icon/svg_display_object.dart';
part 'src/view/paper/paper_app_bar.dart';
part 'src/view/paper/paper_button.dart';
part 'src/view/paper/paper_checkbox.dart';
part 'src/view/paper/paper_dialog.dart';
part 'src/view/paper/paper_dimensions.dart';
part 'src/view/paper/paper_fab.dart';
part 'src/view/paper/paper_icon_button.dart';
part 'src/view/paper/paper_input.dart';
part 'src/view/paper/paper_menu.dart';
part 'src/view/paper/paper_radio_button.dart';
part 'src/view/paper/paper_tabs.dart';
part 'src/view/paper/paper_toast.dart';
part 'src/view/paper/paper_toggle_button.dart';
part 'src/view/paper/paper_wrap.dart';


