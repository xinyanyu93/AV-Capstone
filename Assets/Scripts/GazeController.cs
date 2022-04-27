using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GazeController : MonoBehaviour
{
    public GameObject GazeRight;
    public GameObject GazeLeft;
    public GameObject GazeMiddle;
    public GameObject LookAround;
    public GameObject Robot;
    public float offset;
    public float dist;



    // Start is called before the first frame update
    

    // Update is called once per frame
    void Update()
    {
        Camera maincam = GameObject.Find("Main Camera").GetComponent<Camera>();
        offset = Robot.transform.position.x - maincam.transform.position.x;
        dist=  Vector3.Distance(Robot.transform.position,maincam.transform.position);

        print(offset);

        if (dist > 26){
            LookAround.SetActive(true);
             GazeRight.SetActive(false);
            GazeLeft.SetActive(false);
            GazeMiddle.SetActive(false);

}
        if (dist <26){
            LookAround.SetActive(false);

        if (offset<-2){
            GazeRight.SetActive(true);
            GazeLeft.SetActive(false);
            GazeMiddle.SetActive(false);

        }
        if (offset>-2){
            GazeRight.SetActive(false);
            GazeLeft.SetActive(true);
            GazeMiddle.SetActive(false);
        }
        if ( offset>-2 && offset <2) {
            GazeRight.SetActive(false);
            GazeLeft.SetActive(false);
            GazeMiddle.SetActive(true);
        }

    }
    }
}
