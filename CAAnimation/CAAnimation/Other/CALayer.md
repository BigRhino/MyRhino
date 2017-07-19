#  CALayer

###创建和初始化

+ (instancetype)layer;
- (instancetype)init;
- (instancetype)initWithLayer:(id)layer;
- (nullable instancetype)presentationLayer;
- (instancetype)modelLayer;

###属性方法

###几何结构和层次结构属性

@property CGRect bounds;
@property CGPoint position;
@property CGFloat zPosition;
@property CGPoint anchorPoint;
@property CGFloat anchorPointZ;
@property CATransform3D transform;

- (CGAffineTransform)affineTransform;
- (void)setAffineTransform:(CGAffineTransform)m;

@property CGRect frame;

@property(getter=isHidden) BOOL hidden;


@property(getter=isDoubleSided) BOOL doubleSided;


@property(getter=isGeometryFlipped) BOOL geometryFlipped;

- (BOOL)contentsAreFlipped;


@property(nullable, readonly) CALayer *superlayer;

- (void)removeFromSuperlayer;

@property(nullable, copy) NSArray<CALayer *> *sublayers;


- (void)addSublayer:(CALayer *)layer;

- (void)insertSublayer:(CALayer *)layer atIndex:(unsigned)idx;

- (void)insertSublayer:(CALayer *)layer below:(nullable CALayer *)sibling;
- (void)insertSublayer:(CALayer *)layer above:(nullable CALayer *)sibling;

- (void)replaceSublayer:(CALayer *)layer with:(CALayer *)layer2;


@property CATransform3D sublayerTransform;


@property(nullable, strong) CALayer *mask;

@property BOOL masksToBounds;
