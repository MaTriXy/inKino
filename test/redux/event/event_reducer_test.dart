import 'package:inkino/data/models/actor.dart';
import 'package:inkino/data/models/event.dart';
import 'package:inkino/redux/common_actions.dart';
import 'package:inkino/redux/event/event_state.dart';
import 'package:inkino/redux/event/event_reducer.dart';
import 'package:test/test.dart';

void main() {
  group('EventReducer', () {
    test(
      'when called with UpdateActorsForEventAction, should update event actors when it is a now playing event',
      () {
        var state = new EventState.initial().copyWith(
          nowInTheatersEvents: <Event>[
            new Event(id: '1'),
            new Event(id: 'event-to-update'),
            new Event(id: '2'),
          ],
        );

        var reducedState = eventReducer(
          state,
          new UpdateActorsForEventAction(
            new Event(id: 'event-to-update'),
            <Actor>[
              new Actor(name: 'Eric Seidel', avatarUrl: 'http://erics-avatar'),
              new Actor(name: 'Seth Ladd', avatarUrl: 'http://seths-avatar'),
            ],
          ),
        );

        var nowInTheatersEvents = reducedState.nowInTheatersEvents;
        expect(nowInTheatersEvents[0].actors, isNull);
        expect(nowInTheatersEvents[2].actors, isNull);

        var updatedEvent = nowInTheatersEvents[1];
        expect(updatedEvent.actors.length, 2);
        expect(updatedEvent.actors[0].name, 'Eric Seidel');
        expect(updatedEvent.actors[1].name, 'Seth Ladd');
      },
    );

    test(
      'when called with UpdateActorsForEventAction, should update event actors when it is a upcoming event',
      () {
        var state = new EventState.initial().copyWith(
          comingSoonEvents: <Event>[
            new Event(id: '1'),
            new Event(id: 'event-to-update'),
            new Event(id: '2'),
          ],
        );

        var reducedState = eventReducer(
          state,
          new UpdateActorsForEventAction(
            new Event(id: 'event-to-update'),
            <Actor>[
              new Actor(name: 'Eric Seidel', avatarUrl: 'http://erics-avatar'),
              new Actor(name: 'Seth Ladd', avatarUrl: 'http://seths-avatar'),
            ],
          ),
        );

        var comingSoonEvents = reducedState.comingSoonEvents;
        expect(comingSoonEvents[0].actors, isNull);
        expect(comingSoonEvents[2].actors, isNull);

        var updatedEvent = comingSoonEvents[1];
        expect(updatedEvent.actors.length, 2);
        expect(updatedEvent.actors[0].name, 'Eric Seidel');
        expect(updatedEvent.actors[1].name, 'Seth Ladd');
      },
    );
  });
}
