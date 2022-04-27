using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetActive : MonoBehaviour
{
   public GameObject pathToBeVisualised;
   public GameObject Starship;
   public float Distance;

    // Update is called once per frame
    void Update()
    { 
        Camera maincam = GameObject.Find("Main Camera").GetComponent<Camera>();
        Distance = Vector3.Distance(Starship.transform.position,maincam.transform.position);
      if(Distance>25) 
       {
          pathToBeVisualised.SetActive(false);
      }
      if(Distance<25){
          pathToBeVisualised.SetActive(true);
      }
    }
}
