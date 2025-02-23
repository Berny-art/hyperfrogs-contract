// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


contract FrogsOneOfOne {
    // Data for the 1 of 1 traits
    bytes[] internal OneOfOne_data = [
        bytes(hex'3c706174682066696c6c3d22234146463245322220643d224d34342e38362034322e3636386330202e3531362d2e30383720312e3031322d2e32353820312e34383861342e30353720342e3035372030203020312d2e37323720312e32363620332e3620332e362030203020312d312e3131332e383739632d2e34332e3231382d2e3930372e3332382d312e34332e3332382d2e33363720302d2e37312d2e3033352d312e3033312d2e31303661342e33363820342e3336382030203020312d2e3931342d2e33313620362e31393620362e3139362030203020312d2e3930332d2e353136632d2e3238392d2e3230332d2e35392d2e3433372d2e3930322d2e37303361382e32373720382e3237372030203020302d2e37352d2e353520332e34383520332e3438352030203020302d2e3730332d2e33383720322e333420322e33342030203020302d2e3530342d2e31353320322e37353620322e3735362030203020302d2e3531362d2e303436632d2e32373320302d2e35332e3035382d2e3737332e31373561312e393320312e39332030203020302d2e36312e34343620322e32353220322e3235322030203020302d2e34312e36393120322e32343920322e3234392030203020302d2e3135322e3833326c2d312e35372d2e3263302d2e3531352e3038362d312e3030372e3235382d312e34373661332e3820332e38203020302031202e3732362d312e323320332e33313520332e33313520302030203120312e3130322d2e38333220332e3220332e3220302030203120312e34332d2e333137632e3335392030202e3639392e303420312e3031392e3131382e3332382e30372e3634342e3137352e39352e3331362e3330342e31342e362e3331332e38392e353136613133203133203020302031202e3930322e3638632e3230332e3137312e3339382e3332372e3538362e34363861342e3920342e39203020302030202e35352e3334632e3231322e3131372e3432372e3230372e3634352e32372e32322e3035342e3434362e3037382e36382e30372e3237332030202e3532372d2e3036332e3736322d2e31383861322e303820322e3038203020302030202e3633332d2e353034632e3137312d2e3230332e3330382d2e3434312e34312d2e3731352e3130312d2e3237332e3135322d2e3535382e3135322d2e3835356c312e35372e3231315a6d322e30313520322e32313563302d2e3931342e3133332d312e3736322e3339382d322e35343361362e30343420362e30343420302030203120312e3134392d322e303520352e31393620352e31393620302030203120312e3830352d312e3336632e37312d2e33333620312e3531312d2e35303420322e3430322d2e3530342e383938203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236352e3738312e33393820312e3632392e33393820322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393820322e35343361362e31373420362e3137342030203020312d312e31333720322e30333920352e33313520352e3331352030203020312d312e38313620312e333539632d2e3731312e3332382d312e3531322e3439322d322e3430332e3439322d2e38393820302d312e3730372d2e3136342d322e3432352d2e34393261352e31393720352e3139372030203020312d312e3830352d312e333620362e30363520362e3036352030203020312d312e3134392d322e30333820372e38353320372e3835332030203020312d2e3339382d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373420312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239362e34332e3637312e373720312e31323420312e30322e3435332e32352e39382e33373420312e3538322e3337342e353934203020312e3131342d2e31323520312e3535392d2e33373561332e333820332e333820302030203020312e3133372d312e3032632e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232322d312e373933762d2e32353861362e353820362e35382030203020302d2e3233342d312e373720342e36393220342e3639322030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133372d312e3032632d2e3434352d2e3235372d2e3936382d2e3338362d312e35372d2e3338362d2e36303220302d312e3132352e3132392d312e35372e3338372d2e3434362e32352d2e3831372e35392d312e31313420312e303261342e353820342e35382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323220312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d35312e3334342034342e39333463302d2e3436312e31342d2e3835362e3432322d312e3138342e32382d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938382e31363420312e3237372e3439322e3239372e33322e3434362e3731352e34343620312e3138342030202e34362d2e3134392e3834372d2e34343620312e31362d2e3239372e3331322d2e3732322e3436382d312e3237372e3436382d2e35363320302d2e3938382d2e3135362d312e3237372d2e34363861312e36393820312e3639382030203020312d2e3432322d312e31365a222f3e00000000'),
        bytes(hex'3c706174682066696c6c3d22234146463245322220643d224d34352e3936392033352e33303963302d2e3931342e3133332d312e3736322e3339382d322e35343361362e30343320362e30343320302030203120312e3134392d322e30353120352e31393820352e31393820302030203120312e3830342d312e3336632e3731312d2e33333520312e3531322d2e35303320322e3430332d2e3530332e383938203020312e3730332e31363820322e3431342e35303361352e32383520352e32383520302030203120312e38323820312e333620362e31353620362e31353620302030203120312e31333720322e3035632e3236352e3738322e33393820312e36332e33393820322e353434762e3235376330202e3931342d2e31333320312e3736322d2e33393820322e35343361362e31373520362e3137352030203020312d312e31333720322e303420352e33313320352e3331332030203020312d312e38313720312e333539632d2e37312e3332382d312e3531312e3439322d322e3430322e3439322d2e38393820302d312e3730372d2e3136342d322e3432362d2e34393261352e31393720352e3139372030203020312d312e3830342d312e333620362e30363120362e3036312030203020312d312e3134392d322e30333920372e38353320372e3835332030203020312d2e3339382d322e353433762d2e3235375a6d322e3136382e3235376330202e3632352e30373420312e3232332e32323220312e3739332e3134392e3536332e33373520312e3035392e363820312e3438392e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353934203020312e3131332d2e31323520312e3535392d2e3337352e3435332d2e32352e3833322d2e353920312e3133362d312e303261342e363820342e3638203020302030202e3636382d312e343838632e3134392d2e35372e3232332d312e3136382e3232332d312e373933762d2e32353763302d2e3631382d2e3037382d312e3230372d2e3233342d312e373761342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133372d312e3032632d2e3434352d2e3235372d2e3936392d2e3338362d312e35372d2e3338362d2e36303220302d312e3132352e3132392d312e35372e3338372d2e3434362e32352d2e3831372e35392d312e31313420312e303261342e35333820342e3533382030203020302d2e363820312e3520362e39303520362e3930352030203020302d2e32323220312e373639762e3235375a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d34392e3733342033352e36373663302d2e3436312e3134312d2e3835362e3432322d312e3138342e3238322d2e3332382e3730372d2e34393220312e3237382d2e3439322e3536322030202e3938382e31363420312e3237372e3439322e3239372e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134382e3834372d2e34343520312e31362d2e3239372e3331322d2e3732332e3436392d312e3237372e3436392d2e35363320302d2e3938392d2e3135372d312e3237382d2e343761312e36393820312e3639382030203020312d2e3432322d312e31365a6d31322031382e32303763302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323920312e333620362e31353220362e31353220302030203120312e31333620322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353934203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e3620362e362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d36352e352035342e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d2d32322e3736362d362e33363763302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d34362e352034382e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d342e32333420392e36333363302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d35342e352035382e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d31302e3233342d31362e33363763302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323920312e333620362e31353220362e31353220302030203120312e31333620322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353934203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e3620362e362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d36382e352034322e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a4d35362e3733342033312e38383363302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323920312e333620362e31353220362e31353220302030203120312e31333620322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e3620362e362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d36302e352033322e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d2d362e3736362031322e36333363302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333720322e30333920352e33313520352e3331352030203020312d312e38313620312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d35372e352034352e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d2d32352e3736362e36333363302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d33352e352034362e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938392e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d2d31332e3736362d372e33363763302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d32352e352033392e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938382e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d2d31312e37363620392e36333363302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333720322e30333920352e33313520352e3331352030203020312d312e38313620312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d31372e352034392e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938382e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a6d362e32333420362e36333363302d2e3931342e3133332d312e3736322e3339392d322e35343361362e30343220362e30343220302030203120312e3134382d322e303520352e31393720352e31393720302030203120312e3830352d312e3336632e37312d2e33333620312e3531322d2e35303420322e3430322d2e3530342e383939203020312e3730332e31363820322e3431342e35303461352e32383520352e32383520302030203120312e38323820312e333620362e31353220362e31353220302030203120312e31333720322e3035632e3236362e3738312e33393920312e3632392e33393920322e353433762e3235386330202e3931342d2e31333320312e3736312d2e33393920322e35343361362e31373420362e3137342030203020312d312e31333620322e30333920352e33313520352e3331352030203020312d312e38313720312e333539632d2e37312e3332382d312e3531322e3439322d322e3430322e3439322d2e38393920302d312e3730372d2e3136342d322e3432362d2e34393261352e31393820352e3139382030203020312d312e3830352d312e333620362e30363320362e3036332030203020312d312e3134382d322e30333820372e38353320372e3835332030203020312d2e3339392d322e353433762d2e3235385a6d322e3136382e3235386330202e3632352e30373520312e3232322e32323320312e3739332e3134382e3536322e33373520312e3035382e363820312e3438382e3239372e34332e3637322e373720312e31323520312e30322e3435332e32352e39382e33373420312e3538322e3337342e353933203020312e3131332d2e31323520312e3535382d2e3337352e3435332d2e32352e3833322d2e353920312e3133372d312e30322e3239372d2e3432392e35322d2e3932352e3636382d312e34383761372e313120372e3131203020302030202e3232332d312e373933762d2e32353861362e353620362e35362030203020302d2e3233352d312e373720342e36393420342e3639342030203020302d2e3636382d312e3520332e33383120332e3338312030203020302d312e3133362d312e3032632d2e3434362d2e3235372d2e39372d2e3338362d312e35372d2e3338362d2e36303220302d312e3132362e3132392d312e3537312e3338372d2e3434352e32352d2e3831362e35392d312e31313320312e303261342e35313820342e3531382030203020302d2e363820312e3520362e39303920362e3930392030203020302d2e32323320312e373639762e3235385a222f3e0a3c706174682066696c6c3d22234146463245322220643d224d32372e352035362e323563302d2e34362e31342d2e3835352e3432322d312e3138342e3238312d2e3332382e3730372d2e34393220312e3237372d2e3439322e3536332030202e3938382e31363420312e3237382e3439322e3239362e33322e3434352e3731352e34343520312e3138342030202e34362d2e3134392e3834382d2e34343520312e31362d2e3239372e3331332d2e3732332e3436392d312e3237382e3436392d2e35363220302d2e3938382d2e3135362d312e3237372d2e34363961312e36393820312e3639382030203020312d2e3432322d312e31365a222f3e00000000')
    ];

    string[] internal OneOfOne_traits = [
        "Tadpole",
        "The Mass"
    ];

    // Getter functions
    function getOneOfOneTrait(uint index) external view returns (string memory) {
        return OneOfOne_traits[index];
    }

    function getOneOfOneData(uint index) external view returns (bytes memory) {
        return OneOfOne_data[index];
    }

    function totalOneOfOne() external view returns (uint) {
        return OneOfOne_traits.length;
    }
}
