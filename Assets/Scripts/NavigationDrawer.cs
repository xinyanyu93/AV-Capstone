 using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NavigationDrawer : MonoBehaviour
{ 
    public float speed =0f;
    public float angle = 0f;
    public Vector3 startPosition;
    public Vector3 targetNode; 
    private LineRenderer AvPath;

    public Vector3 point1;
    public Vector3 point2;
    public Vector3 point3;
    public Vector3 point4;
    public Vector3 point5;
    public Vector3 point6;
    public Vector3 point7;
    public Vector3 point8;
    
    //public Vector3 point3;
    // Start is called before the first frame update
    void Start()
    {
       AvPath = GetComponent<LineRenderer>();//g
        AvPath.startWidth = 0.6f;
        AvPath.endWidth = 0.6f;
        AvPath.positionCount = 0;
    }

    // Update is called once per frame
    void Update()
    {
        speed= GameObject.Find("StarshipAuto").GetComponent<CarEngine>().currentSpeed;
        angle = GameObject.Find("StarshipAuto").GetComponent<CarEngine>().newSteer;
        startPosition= GameObject.Find("StarshipAuto").GetComponent<Transform>().position;
        //targetNode =GameObject.Find("StarshipAuto").GetComponent<CarEngine>().relativeVector; 

        //print(targetNode);
        float xPos =GameObject.Find("StarshipAuto").GetComponent<Transform>().forward.x;
        float zPos= GameObject.Find("StarshipAuto").GetComponent<Transform>().forward.z;

        point1 = new Vector3(startPosition.x,0.5f, startPosition.z);
        point2 = new Vector3 (startPosition.x +xPos*2f,0.3f,startPosition.z+zPos*1.5f);
        point3 = new Vector3 (startPosition.x +xPos*3.5f,0.3f,startPosition.z+zPos*2f);
        point4 = new Vector3 (startPosition.x +xPos*4f,0.3f,startPosition.z+zPos*2.5f);
        point5 = new Vector3 (startPosition.x +xPos*5f,0.3f,startPosition.z+zPos*3f);
        point6 = new Vector3 (startPosition.x +xPos*4f,0.3f, startPosition.z+ zPos*4f);
        

        print(xPos);
        print(zPos);
    
        //point1=new Vector3(startPosition.x,0.5f,startPosition.z);

        //point2=new Vector3(startPosition.x+GameObject.Find("StarshipAuto").GetComponent<Transform>().forward.x,0.5f,startPosition.x+GameObject.Find("StarshipAuto").GetComponent<Transform>().forward.z);
       // point2=new Vector3(startPosition.x+targetNode.x,startPosition.y+targetNode.y,startPosition.z+targetNode.z);
        
        //point3= new Vector3(point2.x+speed*Mathf.Atan(angle*Mathf.Deg2Rad),point2.y,point2.z-speed);
       // point2= new Vector3(startPosition.x-10*Mathf.Atan(angle*Mathf.Deg2Rad),startPosition.y,startPosition.z-10);
        DrawAvPath();
        //print(Mathf.Atan(angle*Mathf.Deg2Rad));
        //print( relativeVector1);
        
    }

    void DrawAvPath(){
        AvPath.positionCount=6;
        AvPath.SetPosition(0,point1);
        AvPath.SetPosition(1,point2);
        AvPath.SetPosition(2,point3);
        AvPath.SetPosition(3,point4);
        AvPath.SetPosition(4,point5);
        AvPath.SetPosition(5,point6);
        //AvPath.SetPosition(6,point7);
        //AvPath.SetPosition(7,point8);


    }
}
