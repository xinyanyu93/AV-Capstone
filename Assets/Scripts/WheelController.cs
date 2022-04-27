using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WheelController : MonoBehaviour
{
   [SerializeField] WheelCollider FrontLeft;
   [SerializeField] WheelCollider FrontRight;
   [SerializeField] WheelCollider BackLeft;
   [SerializeField] WheelCollider BackRight;

   [SerializeField] Transform FrontRightTransform;
   [SerializeField] Transform FrontLeftTransform;
   [SerializeField] Transform BackRightTransform;
   [SerializeField] Transform BackLeftTransform;
   

   public float acceleration = 400f;
   public float breakingForce= 200f;
   public float maxTurnAngle = 15f;
   private float currentAcceleration = 0f;
   private float currentBreakForce = 0f;
   private float currentTurnAngle = 0f;

   private void FixedUpdate(){

      //

      currentAcceleration = acceleration * Input.GetAxis("Vertical");
      if (Input.GetKey(KeyCode.Space))
         currentBreakForce = breakingForce;
      else
         currentBreakForce = 0f;
      //Apply acceleration to front wheels
      FrontLeft.motorTorque= currentAcceleration;
      FrontRight.motorTorque= currentAcceleration;
      BackRight.motorTorque= currentAcceleration;
      BackLeft.motorTorque= currentAcceleration;
      

      FrontRight.brakeTorque= currentBreakForce;
      FrontLeft.brakeTorque= currentBreakForce;
      BackRight.brakeTorque= currentBreakForce;
      BackLeft.brakeTorque= currentBreakForce;

      //steering
      currentTurnAngle = maxTurnAngle * Input.GetAxis("Horizontal")* -1;
      FrontLeft.steerAngle = currentTurnAngle;
      FrontRight.steerAngle = currentTurnAngle;

      //update wheel meshes
      //UpdateWheel(FrontLeft,FrontLeftTransform);
      //UpdateWheel(FrontRight,FrontRightTransform);
      //UpdateWheel(BackLeft,BackLeftTransform);
     // UpdateWheel(BackRight,BackRightTransform);

      
   }


   void UpdateWheel ( WheelCollider col, Transform trans){
      
      Vector3 position;
      Quaternion rotation;
      col.GetWorldPose(out position, out rotation);
      trans.position=position;
      trans.rotation=rotation;
   }


}
