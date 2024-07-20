import 'package:ecommerce_app_mobile/sddklibrary/helper/resource.dart';

class ResourceState<T>{
 Resource<T> resource;

 ResourceState(this.resource);
}

class InitResourceState extends ResourceState{
  InitResourceState():super(Resource.stable());

}