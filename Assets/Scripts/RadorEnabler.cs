using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RadorEnabler : MonoBehaviour
{
   public GameObject RadorCircle;
   public GameObject Starship;
   public GameObject naviPath;
   public float Distance;

    // Update is called once per frame
    void Update()
    { 
        Camera maincam = GameObject.Find("Main Camera").GetComponent<Camera>();
        Distance = Vector3.Distance(Starship.transform.position,maincam.transform.position);
      if(Distance>26) 
       {
          RadorCircle.SetActive(false);
          naviPath.SetActive(false);
      }
      if(Distance<26){
          RadorCircle.SetActive(true);
          naviPath.SetActive(true);
      }
    }
}
