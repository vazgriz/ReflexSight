using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move : MonoBehaviour {
    [SerializeField]
    float amplitude = 1;

    [SerializeField]
    float timeScale = 1;

    new Transform transform;
    Vector3 startPosition;

    void Start() {
        transform = GetComponent<Transform>();
        startPosition = transform.position;
    }

    void Update() {
        transform.position = new Vector3(amplitude * Mathf.Sin(Time.time * timeScale), startPosition.y, startPosition.z);
    }
}
