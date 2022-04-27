using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarEngine : MonoBehaviour
{
    public Transform path;
    public float maxSteerAngle = 40f;
    public float turnSpeed = 2f;
    public WheelCollider wheelFL;
    public WheelCollider wheelFR;
    public WheelCollider wheelBL;
    public WheelCollider wheelBR;
    public float maxMotorTorque = 20f;
    public float currentSpeed;
    public float maxSpeed=15f;
    public float maxBrakeTorque = 50f;
    public Vector3 centerOfMass;
    public bool isBraking = false;
    public Vector3 relativeVector;

    [Header("sensors")]
    public float sensorLength = 10f;
    public Vector3 frontSensorPosition = new Vector3(0f,0.2f,0.3f);
    public float sideSensorPosition= 0.4f;
    public float frontSenorAngle=30;
    public float avoidMultiplier;

    private List<Transform> nodes;
    private int currentNode = 0;
    private bool avoiding = false;
    private float targetSensorAngle=0;
    public float newSteer = 0f;
    // Start is called before the first frame update
    void Start()
    {
         GetComponent<Rigidbody>().centerOfMass = centerOfMass;
        Transform[] pathTransform = path.GetComponentsInChildren<Transform>();
      nodes = new List<Transform>();

      for (int i = 0; i < pathTransform.Length; i++){
         if(pathTransform[i]!=path.transform){
            nodes.Add(pathTransform[i]);
         }
         
      }
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        Sensors();
        ApplySteer();
        Drive();
        CheckWaypointDistance();
        Braking();
        LerpToSteerAngle();
    }

    private void Sensors(){
      RaycastHit hit;
      Vector3 sensorStartPos = transform.position;
      sensorStartPos += transform.forward*frontSensorPosition.z;
      sensorStartPos += transform.up*frontSensorPosition.y;
      avoidMultiplier = 0;
      avoiding = false;


      
      //front right

      sensorStartPos += transform.right*sideSensorPosition;

       if(Physics.Raycast(sensorStartPos,transform.forward,out hit, sensorLength)){
         if(!hit.collider.CompareTag("Ground")){
      Debug.DrawLine(sensorStartPos,hit.point);
      //print(hit.point);
      avoiding = true;
      avoidMultiplier -=1f;
      }
      }
     

      //front rightangle

      else if(Physics.Raycast(sensorStartPos, Quaternion.AngleAxis(frontSenorAngle, transform.up) * transform.forward,out hit, sensorLength)){
        if(!hit.collider.CompareTag("Ground")){
      Debug.DrawLine(sensorStartPos,hit.point);
      avoiding = true;
      avoidMultiplier -=0.5f;
      }
      }
      

      
      //print(sensorStartPos);

      //front left

       sensorStartPos -= transform.right*sideSensorPosition*2;

       if(Physics.Raycast(sensorStartPos,transform.forward,out hit, sensorLength)){
         if(!hit.collider.CompareTag("Ground")){
       Debug.DrawLine(sensorStartPos,hit.point);
       avoiding = true;
       avoidMultiplier +=1f;
      }
      }
      
 //front leftangle


       else if(Physics.Raycast(sensorStartPos, Quaternion.AngleAxis(-frontSenorAngle, transform.up) * transform.forward,out hit, sensorLength)){
         if(!hit.collider.CompareTag("Ground")){
       Debug.DrawLine(sensorStartPos,hit.point);
       avoiding = true;
       avoidMultiplier +=0.5f;
      }
      }

      
      //frontcenter
      if (avoidMultiplier== 0){

      if(Physics.Raycast(sensorStartPos,transform.forward,out hit, sensorLength)){
        if(!hit.collider.CompareTag("Ground")){
       Debug.DrawLine(sensorStartPos,hit.point);
       avoiding = true;
       if (hit.normal.x <0){
         avoidMultiplier=-1;
       }
       else{avoidMultiplier=1;}
      }
      }
      }
      
    if(avoiding){

    }
      targetSensorAngle = maxSteerAngle*avoidMultiplier;
      //wheelFL.steerAngle = maxSteerAngle*avoidMultiplier;
      //wheelFR.steerAngle = maxSteerAngle*avoidMultiplier;

    }
    
    
    
    
    
    
    private void ApplySteer(){

      if(avoiding) return;

      relativeVector = transform.InverseTransformPoint(nodes[currentNode].position);
      newSteer= (relativeVector.x / relativeVector.magnitude)*maxSteerAngle;
      targetSensorAngle=newSteer;
      //wheelFL.steerAngle = newSteer;
      //wheelFR.steerAngle = newSteer;
      
      //print(relativeVector);
      
    }
    private void Drive()
    {
      currentSpeed = 2 * Mathf.PI * wheelFL.radius * wheelFL.rpm *60/1000;
      if(currentSpeed< maxSpeed && !isBraking){
      //print(currentSpeed);
      wheelFL.motorTorque = maxMotorTorque;
      wheelFR.motorTorque = maxMotorTorque;
      } else {
         wheelFL.motorTorque = 0;
         wheelFR.motorTorque = 0;
      }

    }

    private void CheckWaypointDistance(){
      if(Vector3.Distance(transform.position,nodes[currentNode].position)<0.5f){
        if (currentNode== nodes.Count-1){
          currentNode=0;
        }
        else{
          currentNode++;
        }
      }
    }
    private void Braking(){
      if(isBraking){
        wheelBL.brakeTorque = maxBrakeTorque;
        wheelBR.brakeTorque = maxBrakeTorque;
      }
      else{
         wheelBL.brakeTorque = 0;
        wheelBR.brakeTorque = 0;
      }
     

    }
    private void LerpToSteerAngle(){
      wheelFL.steerAngle = Mathf.Lerp(wheelFL.steerAngle,targetSensorAngle,Time.deltaTime*turnSpeed);
      wheelFR.steerAngle = Mathf.Lerp(wheelFR.steerAngle,targetSensorAngle,Time.deltaTime*turnSpeed);
    }
}
