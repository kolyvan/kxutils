
#ifndef KIND_OF
#define KIND_OF(obj, klazz) [obj isKindOfClass:[klazz class]]
#endif

#ifndef NSOBJ_ISEQUAL
#define NSOBJ_ISEQUAL(x, y) (x == y || [x isEqual:y])
#endif