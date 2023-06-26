#if __APPLE__

#import "ObjectiveCBindings.h"
#import "JuceHeader.h"
#import "DemoAudioEngine.h"

@interface DemoAudioEngineBindings() {
    ScopedJuceInitialiser_GUI juceInit;
    DemoAudioEngine audioEngine;
}

@end

@implementation DemoAudioEngineBindings

- (void) play: (NSString*) urlString
{
    audioEngine.play(urlString.UTF8String);
}

- (void) stop
{
    audioEngine.stop();
}

- (void) pause
{
    audioEngine.pause();
}

- (void) resume
{
    audioEngine.resume();
}

- (void) setRoomSize: (float) roomSize
{
    audioEngine.setRoomSize (roomSize);
}

- (void) setLowpassCutoff: (float) cutoff
{
    audioEngine.setLowpassCutoff (cutoff);
}

- (void) addWaveformComponentToView: (ViewType) viewToAttachTo            // 2
{
    CGSize size = viewToAttachTo.bounds.size;
    audioEngine.setWaveformComponentSize(size.width, size.height);
    //TODO: Which of the two lines below is correct for this situation?
    //audioEngine.addWaveformComponentToNativeParentView ((__bridge void*)viewToAttachTo);
    audioEngine.addWaveformComponentToNativeParentView ((void*)CFBridgingRetain(viewToAttachTo));
}

- (void) removeWaveformComponentFromView                                // 2
{
    audioEngine.removeWaveformComponentFromNativeParentView();
}

- (void) setPlaybackDidFinish: (Callback) callback      // 3
{
    // Here we need to store the block/lambda in our Obj-C wrapper otherwise it will get deleted
    self.playbackFinishedCallback = callback;
    audioEngine.setPlaybackFinishedCallback(callback);
}

@end

#endif
