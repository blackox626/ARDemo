//
//  ViewController.m
//  ARDemo
//
//  Created by blackox626 on 2022/7/12.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's delegate
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
    
    // Create a new scene
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
//
//
//    // Set the scene to the view
//    self.sceneView.scene = scene;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

//    configuration.planeDetection = ARPlaneDetectionHorizontal;
//
//    configuration.lightEstimationEnabled = YES;
    
    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
    
    
//    SCNNode *cubeNode = [SCNNode nodeWithGeometry:[SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0]];
//    cubeNode.position = SCNVector3Make(0, 0, -0.5); // SceneKit/AR coordinates are in meters
    
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
//    SCNNode *cubeNode = scene.rootNode.clone;
////    cubeNode.position = SCNVector3Make(0, 0, -0.5);
//
//    cubeNode.position = SCNVector3Zero;
//
//    [[cubeNode.childNodes[0] childNodes].firstObject childNodes];
//
//    [self.sceneView.scene.rootNode addChildNode:cubeNode];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray<ARHitTestResult *> *hits = [self.sceneView hitTest:self.view.center types:ARHitTestResultTypeFeaturePoint];
    [self.sceneView.session addAnchor:[[ARAnchor alloc] initWithTransform:hits.lastObject.worldTransform]];
}

#pragma mark - ARSCNViewDelegate

//// Override to create and configure nodes for anchors added to the view's session.
//- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//    SCNNode *node = [SCNNode new];
//
//    // Add geometry to the node...
//
//    return node;
//}
//
//

///  展示正常 ， 有报错 [SceneKit] Error: modifier without code is invalid  ？？？

- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    NSLog(@"did add node");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship/ship.scn"];
            SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/vase/vase.scn"];
            SCNNode *cubeNode = scene.rootNode.clone;
//        SCNNode *cubeNode = [scene.rootNode childNodeWithName:@"vase" recursively:NO];
            cubeNode.position = SCNVector3Make(0, 0, -0.5);

            [node addChildNode:cubeNode];
    });
}


/**
 Called when a node has been updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

/**
 Called when a mapped node has been removed from the scene graph for the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was removed.
 @param anchor The anchor that was removed.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
