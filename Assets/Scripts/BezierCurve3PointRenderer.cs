using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// [ExecuteInEditMode]

public class BezierCurve3PointRenderer : MonoBehaviour
{
    public Transform point1;
    public Transform point2;
    public Transform point3;
    public LineRenderer pathRenderer;
    public int VertexCount = 12;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        //OnDrawGizmos();
         var pointList = new List<Vector3>();
         for(float ratio = 0f/VertexCount;ratio<=1.0f;ratio+=1.0f/VertexCount){
          var tangentLineVertex1 = (Vector3.Lerp(point1.position,point2.position,ratio));
          var tangentLineVertex2 = (Vector3.Lerp(point2.position,point3.position,ratio));
          var bezierPoint = Vector3.Lerp(tangentLineVertex1,tangentLineVertex2,ratio);
          pointList.Add(bezierPoint);
          print(bezierPoint );
        }
        pathRenderer.positionCount = pointList.Count;
        pathRenderer.SetPositions(pointList.ToArray());
        //pathRenderer.alignment = LineAlignment.View;
        
    }

    void OnDrawGizmos(){
        Gizmos.color=Color.green;
        Gizmos.DrawLine(point1.position,point2.position);

        Gizmos.color = Color.cyan;
        Gizmos.DrawLine(point2.position, point3.position);

        Gizmos.color =Color.red;
        for(float ratio = 0.5f/VertexCount;ratio<1.0f;ratio+=1.0f/VertexCount){
        Gizmos.DrawLine(Vector3.Lerp(point1.position,point2.position,ratio)
                       ,Vector3.Lerp(point2.position,point3.position,ratio));
        }


    }
}
