using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour {
    [SerializeField]
    float amplitude;

    [SerializeField]
    float timeScale;

    new Transform transform;
    Quaternion startRotation;

    void Start() {
        transform = GetComponent<Transform>();
        startRotation = transform.rotation;
    }

    void Update() {
        transform.rotation = startRotation * Quaternion.Euler(0, 0, amplitude * Mathf.Cos(Time.time * timeScale));
    }
}
