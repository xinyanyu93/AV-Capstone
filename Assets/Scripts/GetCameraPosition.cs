using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

[RequireComponent(typeof(LineRenderer))]//g

public class GetCameraPosition : MonoBehaviour
{
    float[,] pastPath= new float[8,2];  //过去8个点的坐标
    float[,] predictPath=new float[8,2]; //未来8个点的坐标
    float[,] leftBound=new float[8,2];  //未来8点的左侧边界 
    float[,] rightBound=new float[8,2]; //未来8点的右侧边界
    private LineRenderer myLineRenderer;//g
   

    public float vertexCount=12;
    Quaternion quaternion;	
    // Start is called before the first frame update
    void Start()
    {
        iniPath();
        myLineRenderer = GetComponent<LineRenderer>();//g
        myLineRenderer.startWidth = 0.6f;
        myLineRenderer.endWidth = 0.6f;
        myLineRenderer.positionCount = 0;


    }

    // Update is called once per frame
    void Update()
    {
        
        if (Time.frameCount % 100 == 0)
        {
            Camera maincam = GameObject.Find("Main Camera").GetComponent<Camera>();
            // Debug.Log(maincam.transform.position);
            renewPastPath(maincam.transform.position.x,maincam.transform.position.z);
            predictNext8Path();
            drawPath();
            //drawPathCircle();
            // Debug.Log(Convert.ToString(pastPath[0,0])+'P'+Convert.ToString(pastPath[1,0])+'X'+Convert.ToString(pastPath[2,0])+'/'+Convert.ToString(pastPath[3,0])+'/'+Convert.ToString(pastPath[4,0])+'/'+Convert.ToString(pastPath[5,0])+'/'+Convert.ToString(pastPath[6,0])+'/'+Convert.ToString(pastPath[7,0]));
            // Debug.Log(Convert.ToString(pastPath[0,1])+'P'+Convert.ToString(pastPath[1,1])+'Y'+Convert.ToString(pastPath[2,1])+'/'+Convert.ToString(pastPath[3,1])+'/'+Convert.ToString(pastPath[4,1])+'/'+Convert.ToString(pastPath[5,1])+'/'+Convert.ToString(pastPath[6,1])+'/'+Convert.ToString(pastPath[7,1]));
            // Debug.Log(Convert.ToString(predictPath[0,0])+'N'+Convert.ToString(predictPath[1,0])+'X'+Convert.ToString(predictPath[2,0])+'/'+Convert.ToString(predictPath[3,0])+'/'+Convert.ToString(predictPath[4,0])+'/'+Convert.ToString(predictPath[5,0])+'/'+Convert.ToString(predictPath[6,0])+'/'+Convert.ToString(predictPath[7,0]));
            // Debug.Log(Convert.ToString(predictPath[0,1])+'N'+Convert.ToString(predictPath[1,1])+'Y'+Convert.ToString(predictPath[2,1])+'/'+Convert.ToString(predictPath[3,1])+'/'+Convert.ToString(predictPath[4,1])+'/'+Convert.ToString(predictPath[5,1])+'/'+Convert.ToString(predictPath[6,1])+'/'+Convert.ToString(predictPath[7,1]));
           // List<Vector3> pointList=DrawPredictedPath();
            // string xlist="a";
             
            // List<float> ylist=new List<float>();
            // List<float> zlist=new List<float>();
            // for(int i=0;i<pointList.Count;i++)
            // {
            //     xlist+=(Convert.ToString(pointList[i][0])+'/');
            // }
            // //Debug.Log(xlist);
            // //Debug.Log(pointList.Count);
            // Debug.Log(maincam.transform.position);
            // Debug.Log(Time.frameCount);
        }

    }

    void iniPath()   //初始化 所有的数组 置零
    {
        for (int i=0;i<8;i++)
        {
            for (int j=0;j<2;j++)
            {
                pastPath[i,j]=0;
                predictPath[i,j]=0;
            }
        }   
    }

    void renewPastPath(float x, float y)   // 以一定的速度刷新当前点位，所有数组往前移1位置
    {
        for (int i=0;i<7;i++)
        {
            pastPath[i,0]= pastPath[i+1,0]; //前移一位
            pastPath[i,1]= pastPath[i+1,1];  
        }   
        pastPath[7,0]= x;
        pastPath[7,1]= y;
    }

    void predictNext8Path()  //预测未来8个点的位置 中点位置 需要等pastpath的8个点全部刷新出来后才开始预测
    {
        if ((pastPath[0,1]!=0)||(pastPath[0,0]!=0))
        {
            float[] pastPathX=new float[8];
            float[] pastPathY=new float[8];
            for (int i=0;i<8;i++)
            {
                pastPathX[i]=pastPath[i,0];
                pastPathY[i]=pastPath[i,1];
            }
            // float nextX=nextStep(pastPathX);
            // float nextY=nextStep(pastPathY);
            // predictPath[0,0]=nextX;
            // predictPath[0,1]=nextY;

            for (int i =0;i<8;i++)
            {
                if (i!=0)
                {
                    pastPathX=renewPath(pastPathX,predictPath[i-1,0]);
                    pastPathY=renewPath(pastPathY,predictPath[i-1,1]);
                }
                predictPath[i,0]=nextStep(pastPathX);
                predictPath[i,1]=nextStep(pastPathY);
            }




            // float newPointx=0;
            // float newPointy=0;
            // for(int i=0;i<8;i++)  //获得预测第一点的X 和Y   第I个权重为I
            // {
            //     newPointx+= pastPath[i,0] *(i+1);
            //     newPointy+= pastPath[i,1] *(i+1);
            // }
            // newPointx=newPointx/(1+2+3+4+5+6+7+8)*1;   //除以权重   
            // newPointy=newPointx/(1+2+3+4+5+6+7+8)*1;
            // //获得新点后，所有的预测点 后移一位
            // for (int i=7;i>0;i--)
            // {
            //     predictPath[i,0]=predictPath[i-1,0];
            //     predictPath[i,1]=predictPath[i-1,1];
            // }
            // predictPath[0,0]=newPointx;
            // predictPath[0,1]=newPointy;

            // // for (i=0;i<8;i++)  //X和Y加上一个随机数
            // // {

            // // }

        }
    }

    float nextStep(float[] pastPath,int rand=1)
    {
        System.Random ran = new System.Random();
        float newPoint=0;
        for(int i=1;i<8;i++)  //获得预测第一点的X 和Y   第I个权重为I
        {
            newPoint+= (pastPath[i]-pastPath[i-1]) *(i+1);
        }
        float deltaNew=newPoint/(2+3+4+5+6+7+8);
        // return deltaNew*(ran.Next(rand)/10+1)
        // -+ pastPath[7];
        return 1*deltaNew+ pastPath[7];
    }

    float[] renewPath (float[] oldPath, float newPoint)
    {
        for (int i=1;i<8;i++)
            {
                oldPath[i-1]=oldPath[i];
            }
        oldPath[7]=newPoint;
        return oldPath;
    }

    //List<Vector3> DrawPredictedPath(){

       // List<Vector3> pointList= new List<Vector3>();//g
    void drawPath()
    {
        myLineRenderer.positionCount = 8;
        myLineRenderer.SetPosition(0, transform.position);
        for ( int i=0; i<8; i++)
        {
            Vector3 pointPosition = new Vector3(predictPath[i,0], 0.15f,predictPath[i,1]);
            myLineRenderer.SetPosition(i,pointPosition);    
        }
    }

    


    void drawPathCircle()
    {      
        LineRenderer line=  GetComponent<LineRenderer>();
        float R=0.1f;
        int positionCount=180*8;
        float angle = 360f / (positionCount/8- 1);
        line.positionCount = positionCount;
        for ( int i=0; i<8; i++)
        {
            Vector3 v=new Vector3(predictPath[i,0], 0.1f,predictPath[i,1]);
            for (int ii = 0+180*i; ii < positionCount; ii++)
            {
                if (ii != 0)
                {
                    //默认围着z轴画圆，所以z值叠加，叠加值为每两个点到圆心的夹角
                    quaternion = Quaternion.Euler(quaternion.eulerAngles.x, quaternion.eulerAngles.y+ angle , quaternion.eulerAngles.z);
                }
                //Quaternion与Vector3的右乘操作（*）返回一个将原有向量做旋转操作后的新向量.列如：Quaternion.Euler(0, 90, 0) * Vector3(0.0, 0.0, -10) 相当于把向量Vector3(0.0, 0.0, -10)绕y轴旋转90度，得到的结果为Vector3(-10, 0.0.0.0)
                Vector3 forwardPosition = v + quaternion * Vector3.left * R;
                line.SetPosition(ii, forwardPosition);
            }

            

        }
    }
        //myLineRenderer.positionCount = 8;
        //myLineRenderer.SetPosition(0, transform.position);

        //for ( int i=0; i<7; i++){

            //Vector3 pointPosition1 = new Vector3(predictPath[i,0], 1,predictPath[i,1]);
           // Vector3 pointPosition2 = new Vector3(predictPath[i+1,0], 1,predictPath[i+1,1]);
           // pointList.Add(pointPosition1);
           // for (float ratio=0; ratio<10; ratio++)
           // {
              //  Vector3 curve =Vector3.Lerp(pointPosition1,pointPosition2,1/ratio);
              //  pointList.Add(curve);
           // } 
       // }

            // deltaX=(predictPath[i+1,0]-predictPath[i,0])/12;
            // deltaY=predictPath[i+1,1]-predictPath[i,1]);

            // for (int j=0;j<12;j++)
            // {
            // }
            // pointList.            
       // myLineRenderer.positionCount = pointList.Count;
        // myLineRenderer.positionCount = pointList.Count.
       //for (int i=0; i<pointList.Count;i++)
       // {
           // myLineRenderer.SetPosition(i,pointList[i]);
       // }
       // return pointList;    


        

    }

